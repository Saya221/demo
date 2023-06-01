Rails.application.routes.draw do
  root to: redirect("/swagger/index.html")

  extend ApiRoutes
end
