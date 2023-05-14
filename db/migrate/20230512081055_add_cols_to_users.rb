class AddColsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :status, :integer, default: User.statuses[:inactive]
    add_column :users, :confirmed_at, :datetime
  end
end
