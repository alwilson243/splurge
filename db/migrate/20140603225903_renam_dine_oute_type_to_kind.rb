class RenamDineOuteTypeToKind < ActiveRecord::Migration
  def change
    rename_column :dine_outs, :type, :kind
  end
end
