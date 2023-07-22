# frozen_string_literal: true

# frozen_literal_string: true

class Job < ApplicationRecord
  # Associations
  belongs_to :creator, class_name: User.name
  belongs_to :last_updater, class_name: User.name
  has_many :clients_jobs, dependent: :destroy
  has_many :clients, through: :clients_jobs

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :salary, presence: true
  validates :working_hours, numericality: { greater_than: 0, less_than: 10, only_integer: true }

  # Enumerations
  enum salary_currency: %i[USD EUR JPY]
end
