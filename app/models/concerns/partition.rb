# frozen_string_literal: true

module Partition
  extend ActiveSupport::Concern

  class_methods do
    def set_table_name(user_id = nil)
      self.table_name =
        user_id.present? ? "#{table_name}_#{(Zlib.crc32(user_id) % 1000) + 1}" : get_first_partition
    end

    def get_first_partition
      reset_table_name
      connection.tables.sort.find { |t| t.start_with?("#{table_name}_") } || table_name
    end

    def union_all_partitions
      reset_table_name
      partitions = connection.tables.grep(/\A#{Regexp.escape(table_name)}_\d+\z/)
      combined_subqueries(partitions)
    end

    private

    def reset_table_name
      self.table_name = name.underscore.pluralize
    end

    def combined_subqueries(partitions)
      subqueries = Arel::Nodes::SqlLiteral.new(
        partitions.map do |partition|
          select(Arel.star).from(partition).with_deleted.to_sql
        end.join(" UNION ALL ")
      )
      execute(subqueries)
    end

    def execute(query)
      table = if query.present?
                Arel::Nodes::Grouping.new(query).as(table_name)
              else
                get_first_partition
              end
      from(table)
    end
  end
end
