# Clockwork

# require "clockwork"

# MultiTenants::Application.load_tasks

# module Clockwork
#   every(1.minute, "Remove unused attachments") do
#     Rake::Task["remove:unused_attachments"].invoke
#     Rake::Task["remove:unused_attachments"].reenable
#   end
# end
