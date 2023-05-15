require "sidekiq/web"

module SidekiqRoutes
  def self.extended(router)
    router.instance_exec do

      mount Sidekiq::Web, at: "/sidekiq"

    end
  end
end
