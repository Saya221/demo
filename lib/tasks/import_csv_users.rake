# frozen_string_literal: true

namespace :import_csv do
  desc "Import users from CSV"
  task users: :environment do
    ActiveRecord::Base.transaction do
      index = 0
      CSV.foreach(ENV["FILE_PATH"], headers: true).each_with_index do |row, i|
        # Password handle
        password = row["password"]&.strip
        password = password.present? ? password : nil

        # User params
        users_params = {
          name: row["name"]&.strip,
          email: row["email"]&.strip,
          password:
        }

        # Create user
        index = i
        User.create! users_params
        print "\033[32m.\033[0m"
      end
    rescue ActiveRecord::RecordInvalid => e
      puts "\033[31m\nLine: #{index}, #{e.message}\033[0m"

      raise ActiveRecord::Rollback
    end
  end
end
