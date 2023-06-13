module ApiRoutes
  def self.extended(router)
    router.instance_exec do

      namespace :api, format: :json do
        namespace :v1 do
          # HealthChecks
          get :ping, to: "health_checks#ping"
        end
      end

    end
  end
end
