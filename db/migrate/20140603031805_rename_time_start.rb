class RenameTimeStart < ActiveRecord::Migration
  def change
  	rename_column :reservations, :timeStart, :time_start
  end
end
