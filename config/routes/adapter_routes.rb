module AdapterRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :adpater do
      end
    end
  end
end
