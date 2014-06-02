class AddRidToFoodItems < ActiveRecord::Migration
  def change
  	add_column :food_items, :restaurants_id, :string
  end
end
