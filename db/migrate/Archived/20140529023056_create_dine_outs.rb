class CreateDineOuts < ActiveRecord::Migration
  def change
    create_table :dine_outs do |t|
      t.references :restaurants
      t.string :name
      t.string :kind
      t.string :phone_num
      t.string :address
      t.text :meal, array: true, null: false, default: '{}'

      t.timestamps
    end
  end
end
