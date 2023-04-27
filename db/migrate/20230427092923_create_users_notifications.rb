class CreateUsersNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :users_notifications do |t|
      t.references :user
      t.references :notification

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
