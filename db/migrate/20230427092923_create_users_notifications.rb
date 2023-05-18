class CreateUsersNotifications < ActiveRecord::Migration[7.0]
  def up
    create_table :users_notifications, id: :uuid do |t|
      t.datetime :read_at
      t.references :user, type: :uuid
      t.references :notification, type: :uuid

      t.datetime :deleted_at
      t.timestamps
    end
  end

  def down
    connection.tables.each do |table|
      drop_table table if table.start_with?("users_notifications_")
    end

    drop_table :users_notifications
  end
end
