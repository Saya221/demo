class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :topic, default: 1
      t.text :content
      t.references :creator

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
