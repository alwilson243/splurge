class ResetMenusFoodItems < ActiveRecord::Migration
  def change
  	drop_table :food_items # add category:string
  	drop_table :menus
  	remove_column :dine_outs, :meal
  	add_column :dine_outs, :meal, :text
  	add_column :restaurants, :email, :string
  end
end
