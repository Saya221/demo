class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.string :scope
      t.string :version, default: "1.0"
      t.boolean :latest, default: true
      t.references :creator, type: :uuid
      t.references :last_updater, type: :uuid

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
