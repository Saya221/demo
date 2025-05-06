module TurboHotwireRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :turbo_hotwire do
        get :sites, to: "sites#index"
      end
    end
  end
end
