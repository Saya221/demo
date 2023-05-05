class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships, id: :uuid do |t|
      t.references :follower, type: :uuid
      t.references :followed, type: :uuid

      t.datetime :deleted_at
      t.timestamps
    end

    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
