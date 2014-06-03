class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :owner
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
