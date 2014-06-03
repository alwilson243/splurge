class SpecialNotesChangePhoneNumType < ActiveRecord::Migration
  def change
  	add_column :restaurants, :special_notes, :text
  	add_column :restaurants, :reserveCap, :integer
  	add_column :restaurants, :lateLimit, :integer
  	change_column :dine_outs, :phone_num, :string
  end
end
