class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :restaurants
      t.string :name
      t.integer :party_size
      t.datetime :timeStart

      t.timestamps
    end
  end
end
