class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles, type: :uuid do |t|
      t.string :name
      t.references :creator, type: :uuid
      t.references :last_updater, type: :uuid

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
