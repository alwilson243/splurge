class Reservation < ActiveRecord::Base
	default_scope{ order('meal_time ASC') }
    belongs_to :restaurant
    validates :restaurants_id, presence: true
    validates :name, presence: true
    validates :party_size, presence: true
    validates :timeStart, presence: true
end
