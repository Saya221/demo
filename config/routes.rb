Rails.application.routes.draw do
  # FE

  root to: "static_pages#index"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :shared_urls, only: %i(new create)
  resources :users, only: %i(create new show)

  # BE

  # root to: redirect("/swagger/index.html"
  namespace :api, format: :json do
    namespace :v1 do
      resources :sign_up_users, only: %i(create)
      resources :shared_urls, only: %i(index)
      resources :users, only: [] do
        resources :shared_urls, only: %i(index create), controller: "users/shared_urls"
      end
      resource :users, only: %i(show)

      post :login, to: "sessions#login"
      delete :logout, to: "sessions#logout"
    end
  end
end
