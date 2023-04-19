set :environment, "development"

every 30.minutes do
  rake "remove_unused_attachments:remove"
end
