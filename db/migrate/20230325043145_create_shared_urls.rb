class CreateSharedUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :shared_urls, id: :uuid do |t|
      t.string :url
      t.references :user, type: :uuid

      t.timestamps
    end
  end
end
