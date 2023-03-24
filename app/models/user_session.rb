# frozen_string_literal: true

class UserSession < ApplicationRecord
  acts_as_paranoid

  before_create :gen_uniq_session_token

  belongs_to :user

  private

  def gen_uniq_session_token
    self.session_token =
      loop do
        uniq_token = SecureRandom.urlsafe_base64
        break uniq_token unless self.class.exists? session_token: uniq_token
      end
  end
end
