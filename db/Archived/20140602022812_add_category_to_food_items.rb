class AddCategoryToFoodItems < ActiveRecord::Migration
  def change
  	create_table :food_items do |t|
      t.string :name
      t.float :price
      t.string :description
      t.string :category

      t.timestamps
  	end
  end
end
