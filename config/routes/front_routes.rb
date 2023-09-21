module FrontRoutes
  def self.extended(router)
    router.instance_exec do
      root to: "static_pages#index"

      get "/signup", to: "users#new"
      get "/login", to: "sessions#new"
      post "/login", to: "sessions#create"
      delete "/logout", to: "sessions#destroy"

      resources :shared_urls, only: %i(new create)
      resources :users, only: %i(create new show)


      # Custom Errors
      match "*path", to: "application#render404", via: :all
      match "*path", to: "application#render500", via: :all
    end
  end
end
