class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :email, null: false, index: {unique: true}
      t.string :password_encrypted, null: false
      t.integer :role, default: User.roles[:staff]
      t.integer :status, default: User.statuses[:inactive]
      t.datetime :confirmed_at

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
