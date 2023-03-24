Rails.application.routes.draw do
  root to: redirect("/swagger/index.html")

  namespace :api, format: :json do
    namespace :v1 do

      resource :users, only: %i(show)

      post :login, to: "sessions#login"
      delete :logout, to: "sessions#logout"
    end
  end
end
