class Reservation < ActiveRecord::Base
	default_scope{ order('meal_time ASC') }
    belongs_to :restaurant
    validates :restaurants_id, presence: true
end
