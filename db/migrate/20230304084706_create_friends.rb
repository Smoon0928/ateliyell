class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|

      t.timestamps
      t.integer :follow_id,null: false,index: false
      t.integer :follower_id,null: false,index: false
    end
  end
end
