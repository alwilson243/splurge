class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :entree
      t.float :price
      t.string :notes

      t.timestamps
    end
  end
end
