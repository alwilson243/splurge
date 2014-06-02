class AddDineOutFKandRenameMealTimeType < ActiveRecord::Migration
  def change
  	add_foreign_key "dine_outs", "restaurants", name: "dine_outs_restaurant_id_fk"
  	rename_column :dine_outs, :type, :kind
  	rename_column :reservations, :meal_time, :timeStart
  end
end
