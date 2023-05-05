# frozen_string_literal: true

module PartitionConcerns
  extend ActiveSupport::Concern

  class_methods do
    def set_table_name(user_id = nil)
      self.table_name = user_id.present? ? get_table_name(user_id) : get_first_partition_table
    end

    def get_table_name(user_id)
      "#{table_name}_" + (Zlib.crc32(user_id) % 1000).to_s
    end

    def get_first_partition_table
      first_partition_table = connection.tables.find { |t| t.start_with?("#{table_name}_") }
      first_partition_table.present? ? first_partition_table : table_name
    end

    def union_all_partition_tables
      self.table_name = name.underscore.pluralize
      partition_table_prefix = "#{table_name}_"
      partition_tables = connection.tables.select do |t|
        t.start_with?(partition_table_prefix)
      end
      subqueries = partition_tables.map do |table_name|
        Arel::Nodes::SqlLiteral.new("SELECT * FROM #{table_name}")
      end
      combined_query = Arel::Nodes::SqlLiteral.new(subqueries.join(" UNION ALL "))
      self.from("(#{combined_query.to_s}) as #{table_name}")
    end
  end
end
