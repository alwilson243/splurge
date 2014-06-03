class Reservation < ActiveRecord::Base
	default_scope{ order('time_start ASC') }
    belongs_to :restaurant
    validates :restaurants_id, presence: true
    validates :name, presence: true
    validates :party_size, presence: true
    validates :time_start, presence: true
end
