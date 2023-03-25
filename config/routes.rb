Rails.application.routes.draw do
  # root to: redirect("/swagger/index.html")
  root to: "home#index"

  namespace :api, format: :json do
    namespace :v1 do

      resources :sign_up_users, only: %i(create)
      resources :shared_urls, only: %i(create)
      resources :users_shared_urls, only: %i(index)
      resources :relationships, only: %i(create)
      resources :users_relationships, only: %i(index)
      resources :users, only: %i(index)

      post :login, to: "sessions#login"
      delete :logout, to: "sessions#logout"
    end
  end
end
