class CreateTenants < ActiveRecord::Migration[7.0]
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :host

      t.datetime :deleted_at
      t.timestamps
    end

    add_index :tenants, :host, unique: true
  end
end
