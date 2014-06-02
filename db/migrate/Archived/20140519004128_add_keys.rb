class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "reservations", "restaurants", name: "reservations_restaurant_id_fk"
  end
end
