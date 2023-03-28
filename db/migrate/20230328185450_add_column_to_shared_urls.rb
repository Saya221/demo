class AddColumnToSharedUrls < ActiveRecord::Migration[7.0]
  def change
    add_column :shared_urls, :movie_title, :string, after: :url
    add_column :shared_urls, :thumbnail_url, :string, after: :url
    add_column :shared_urls, :description, :text, after: :url
  end
end
