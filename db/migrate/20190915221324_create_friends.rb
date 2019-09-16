class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :asker_id
      t.integer :replyer_id
      t.boolean :accepted, default: false

      t.timestamps
    end
    add_index "friends", ["asker_id"], name: "index_friends_on_asker_id", using: :btree
    add_index "friends", ["replyer_id"], name: "index_friends_on_replyer_id", using: :btree
  end
end
