# frozen_string_literal: true

module Partition
  extend ActiveSupport::Concern

  class_methods do
    def set_table_name(user_id = nil)
      self.table_name =
        user_id.present? ? "#{table_name}_#{Zlib.crc32(user_id) % 1000}" : get_first_partition_table
    end

    def get_first_partition_table
      reset_table_name
      connection.tables.find { |t| t.start_with?("#{table_name}_") } || table_name
    end

    def union_all_partition_tables
      reset_table_name
      partition_tables = connection.tables.grep(/\A#{Regexp.escape(table_name)}_\d+\z/)
      combined_and_execute_query(partition_tables)
    end

    private

    def reset_table_name
      self.table_name = name.underscore.pluralize
    end

    def combined_and_execute_query(partition_tables)
      combined_query = Arel::Nodes::SqlLiteral.new(
        partition_tables.map do |table|
          select(Arel.star).from(table).with_deleted.to_sql
        end.join(" UNION ALL ")
      )
      from(Arel::Nodes::Grouping.new(combined_query).as(table_name))
    end
  end
end
