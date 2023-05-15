module ApiRoutes
  def self.extended(router)
    router.instance_exec do

      namespace :api, format: :json do
        namespace :v1 do
          resources :sign_up_users, only: %i(create)
          resources :shared_urls, only: %i(index)
          resources :notifications, only: %i(create)

          resource :users, only: %i(show) do
            resources :shared_urls, only: %i(index create), controller: "users/shared_urls"
          end

          post :login, to: "sessions#login"
          delete :logout, to: "sessions#logout"

          # HealthChecks
          get :ping, to: "health_checks#ping"
        end
      end

    end
  end
end
