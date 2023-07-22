# frozen_string_literal: true

class Client < ApplicationRecord
  # Associations
  belongs_to :creator, class_name: User.name
  belongs_to :last_updater, class_name: User.name
  has_many :clients_jobs, dependent: :destroy
  has_many :jobs, through: :clients_jobs

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
