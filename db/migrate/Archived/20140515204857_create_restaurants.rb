class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
    t.string   :name
    t.string   :owner
    t.string   :phone
    t.string   :address
    
    t.time     :sundayOpen
    t.time     :sundayClose
    t.time     :mondayOpen
    t.time     :mondayClose
    t.time     :tuesdayOpen
    t.time     :tuesdayClose
    t.time     :wednesdayOpen
    t.time     :wednesdayClose
    t.time     :thursdayOpen
    t.time     :thursdayClose
    t.time     :fridayOpen
    t.time     :fridayClose
    t.time     :saturdayOpen
    t.time     :saturdayClose
    
    t.string   :password_digest
    t.string   :remember_token
    t.string   :email

      t.timestamps
    end
  end
end
