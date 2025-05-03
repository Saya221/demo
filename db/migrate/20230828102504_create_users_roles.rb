class CreateUsersRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :users_roles do |t|
      t.references :user, type: :uuid
      t.references :role, type: :uuid

      t.timestamps
    end

    add_index :users_roles, [:user_id, :role_id], unique: true
  end
end
