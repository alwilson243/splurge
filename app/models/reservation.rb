class Reservation < ActiveRecord::Base
	default_scope{ order('meal_time ASC') }
end
