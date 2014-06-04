class AddTimeGimmeToDineOuts < ActiveRecord::Migration
  def change
  	add_column :dine_outs, :time_gimme, :datetime
  end
end
