class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients, id: :uuid do |t|
      t.string :address
      t.string :description
      t.string :name
      t.string :phone_number
      t.references :creator, type: :uuid
      t.references :last_updater, type: :uuid

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
