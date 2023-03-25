class CreateSharedUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :shared_urls do |t|
      t.string :url
      t.references :user

      t.timestamps
    end
  end
end
