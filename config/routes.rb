Rails.application.routes.draw do
  # root to: redirect("/swagger/index.html"

  root to: "static_pages#index"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :shared_urls, only: %i(create)
  resources :relationships, only: %i(create destroy)
  resources :users, only: %i(create new show)

  namespace :api, format: :json do
    namespace :v1 do
      resources :sign_up_users, only: %i(create)
      resources :shared_urls, only: %i(create)
      resources :users_shared_urls, only: %i(index)
      resources :relationships, only: %i(create)
      resources :users_relationships, only: %i(index)

      resource :users, only: %i(show)

      post :login, to: "sessions#login"
      delete :logout, to: "sessions#logout"
    end
  end
end
