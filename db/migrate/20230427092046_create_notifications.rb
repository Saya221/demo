class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications, id: :uuid do |t|
      t.integer :topic, default: 1
      t.text :content
      t.references :creator, type: :uuid

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
