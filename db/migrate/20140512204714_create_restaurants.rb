class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|

      t.timestamps
    end
  end
end
