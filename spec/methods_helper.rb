# frozen_string_literal: true

require "factory_bot_rails"

module MethodsHelper
  UUID10 = "1aa5b0c5-4d4c-4c32-bd4a-392462dcaca0" # Zlib.crc32(UUID_10) % 1000 = 10
  UUID577 = "b53777ec-35bf-4849-9470-bd9b7b335067" # Zlib.crc32(UUID_577) % 1000 = 577

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

  def create_partition_tables(described_class, uuids)
    ActiveRecord::Base.connection.execute("CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\"")
    iterator_create_partition_tables(described_class, uuids)
  end

  private

  def iterator_create_partition_tables(described_class, uuids)
    type = described_class.name.underscore.to_sym
    crc32_uuid = { uuid10: 10, uuid577: 577 }

    uuids.each do |uuid|
      ActiveRecord::Base.connection.execute(
        <<-SQL
          CREATE TABLE IF NOT EXISTS #{described_class.name.underscore.pluralize}_#{crc32_uuid[uuid]} (
            #{fields(type)}
          )
        SQL
      )
    end
  end

  def fields(type)
    {
      users_notification: "id uuid PRIMARY KEY DEFAULT uuid_generate_v4(), user_id uuid REFERENCES users(id),
                           notification_id uuid REFERENCES notifications(id), read_at timestamp,
                           deleted_at timestamp, created_at timestamp, updated_at timestamp"
    }[type]
  end
end
