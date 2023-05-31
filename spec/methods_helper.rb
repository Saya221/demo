# frozen_string_literal: true

require "factory_bot_rails"

module MethodsHelper
  UUID11 = "1aa5b0c5-4d4c-4c32-bd4a-392462dcaca0" # Zlib.crc32(UUID_10) % 1000 + 1 = 11
  UUID578 = "b53777ec-35bf-4849-9470-bd9b7b335067" # Zlib.crc32(UUID_577) % 1000 + 1 = 578

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
      Api::V1::JwtProcessingService.new(current_user:,
                                        current_session:,
                                        current_time:).encode

    request.headers.merge! "Jwt-Authorization": "Bearer #{access_token}"
  end

  def current_time
    @current_time ||= Time.current.to_i
  end
end
