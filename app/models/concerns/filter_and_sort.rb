# frozen_string_literal: true

module FilterAndSort
  extend ActiveSupport::Concern

  class_methods do
    def filter_by(conditions = {})
      return all unless conditions.is_a?(Hash)

      conditions.reduce(all) do |query, (key, value)|
        query.where(key => value)
      end
    end

    def sort_by(conditions = {})
      @conditions = conditions

      order(handle_conditions)
    end

    private

    attr_reader :conditions

    def handle_conditions
      default_sort = { updated_at: :desc }

      return default_sort unless conditions.is_a?(Hash)

      key = conditions.keys.first&.to_sym
      direction = conditions.values.first&.to_sym

      processing(key, direction, default_sort)
    end

    def processing(key, direction, default)
      key = key.in?(attribute_names.map(&:to_sym)) ? key : :updated_at
      direction = direction.in?(SORT_DIRECTIONS) ? direction : :desc

      key == :updated_at ? { key => direction } : { key => direction }.merge(default)
    end
  end
end
