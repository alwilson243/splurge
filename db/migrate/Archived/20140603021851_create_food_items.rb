class CreateFoodItems < ActiveRecord::Migration
  def change
    create_table :food_items do |t|
      t.integer  :restaurants_id
      t.string   :name
      t.float    :price
      t.string   :description
      t.string   :category

      t.timestamps
    end
  end
end
