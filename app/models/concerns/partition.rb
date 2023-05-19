# frozen_string_literal: true

module Partition
  extend ActiveSupport::Concern

  class_methods do
    def set_table_name(user_id = nil)
      reset_table_name
      # ActiveRecord does not cache table metadata, so if a table is dropped from the database,
      # ActiveRecord will raise an error immediately when you try to access it.
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

  included do
    before_validation :looking_for_partition

    def looking_for_partition
      table_name = calc_partition(user_id)
      sanitized_table_name = ActiveRecord::Base.sanitize_sql(table_name)
      sanitized_existing_table_name = ActiveRecord::Base.sanitize_sql(self.class.table_name)
      ActiveRecord::Base.connection.execute(
        "CREATE TABLE IF NOT EXISTS #{sanitized_table_name}
        (LIKE #{sanitized_existing_table_name} INCLUDING CONSTRAINTS)"
      )
      # ActiveRecord caches table metadata for performance.
      # It throws an error when accessing the database after a dropped table.
      # The error is raised at the point of accessing the database, not immediately after dropping the table.
      self.class.table_name = table_name
    end

    def calc_partition(user_id = nil)
      self.class.reset_table_name
      table_name = self.class.table_name
      user_id.present? ? "#{table_name}_#{(Zlib.crc32(user_id) % 1000) + 1}" : "#{table_name}_0"
    end
  end
end
