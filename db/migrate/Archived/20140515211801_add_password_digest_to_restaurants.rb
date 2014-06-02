class AddPasswordDigestToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :password_digest, :string
  end
end
