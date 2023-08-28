class CreateRolesPermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :roles_permissions do |t|

      t.timestamps
    end
  end
end
