class CreateFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :followers, id: false do |t|
      t.bigint :user_id, null: false
      t.bigint :follower_id, null: false
    end
    add_index :followers, :user_id
  end
end
