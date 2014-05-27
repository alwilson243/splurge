class CreateFoodItems < ActiveRecord::Migration
  def change
    create_table :food_items do |t|
      t.string :name
      t.float :price
      t.string :description

      t.timestamps
    end
  end
end
