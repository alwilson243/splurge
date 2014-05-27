class CreateDineOuts < ActiveRecord::Migration
  def change
    create_table :dine_outs do |t|
      t.string :name
      t.string :type
      t.string :phone_num
      t.string :address
      
      

      t.timestamps
    end
  end
end
