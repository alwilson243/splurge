class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :name
      t.integer :party_size
      t.datetime :meal_time

      t.timestamps
    end
  end
end
