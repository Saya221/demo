class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs, id: :uuid do |t|
      t.string :description
      t.string :name
      t.integer :salary
      t.integer :salary_currency, default: 0
      t.integer :working_hours
      t.references :creator, type: :uuid
      t.references :last_updater, type: :uuid

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
