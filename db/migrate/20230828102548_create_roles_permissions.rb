class CreateRolesPermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :roles_permissions do |t|
      t.references :role, type: :uuid
      t.references :permission, type: :uuid

      t.timestamps
    end

    add_index :roles_permissions, [:role_id, :permission_id], unique: true
  end
end
