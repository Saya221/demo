# frozen_string_literal: true

class ClientsJob < ApplicationRecord
  # Associations
  belongs_to :client
  belongs_to :job

  # Validations
  validates :job_id, uniqueness: { case_sensitive: false, scope: :client_id }
end
