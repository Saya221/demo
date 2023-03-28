# frozen_string_literal: true

require "factory_bot_rails"

module MethodsHelper
  def response_data
    JSON.parse response.body, symbolize_names: true
  end

  def convert_serialize(data)
    JSON.parse data.to_json, symbolize_names: true
  end

  def login(user: nil)
    current_user = user || create(:user)
    current_session = create :user_session, user: current_user
    access_token =
      Api::V1::JwtProcessingService.new(current_user: current_user,
                                        current_session: current_session,
                                        current_time: current_time).encode

    request.headers.merge! "Jwt-Authorization": "Bearer #{access_token}"
  end

  def current_time
    @current_time ||= Time.current.to_i
  end
end
