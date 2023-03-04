class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|

      t.timestamps
      t.integer :user_id, null: false
      t.integer :product_id, null: false
    end
  end
end
