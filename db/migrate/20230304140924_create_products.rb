class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|

      t.timestamps
      t.integer :genre_id,null: false,index: false
      t.integer :user_id,null: false
      t.string :name,null: false,index: false
      t.text :introduction,null: false
    end
  end
end
