Rails.application.routes.draw do
  # FE
  extend FrontRoutes

  # BE
  extend TurboHotwireRoutes
  extend ApiRoutes
  extend SidekiqRoutes
end
