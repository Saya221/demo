class CreateUserSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_sessions, id: :uuid do |t|
      t.string :session_token
      t.string :login_ip
      t.string :browser
      t.references :user, type: :uuid

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
