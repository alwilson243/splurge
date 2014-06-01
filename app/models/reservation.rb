class Reservation < ActiveRecord::Base
	default_scope{ order('timeStart ASC') }
    belongs_to :restaurant
    # validates :restaurants_id, presence: true
    validates :name, presence: true
    validates :party_size, presence: true
    validates :timeStart, presence: true
end
