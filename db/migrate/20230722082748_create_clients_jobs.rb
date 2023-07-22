class CreateClientsJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :clients_jobs, id: :uuid do |t|
      t.references :client, type: :uuid
      t.references :job, type: :uuid

      t.timestamps
    end
  end
end
