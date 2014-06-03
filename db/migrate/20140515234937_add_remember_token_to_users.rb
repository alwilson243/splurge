class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
    add_column :restaurants, :remember_token, :string
    add_index  :restaurants, :remember_token
  end
end