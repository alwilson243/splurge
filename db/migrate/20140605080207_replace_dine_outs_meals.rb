class ReplaceDineOutsMeals < ActiveRecord::Migration
  def change
  	remove_column :dine_outs, :meal
  	add_column :dine_outs, :meal, :text
  end
end
