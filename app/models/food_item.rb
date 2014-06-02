class FoodItem < ActiveRecord::Base
	default_scope{ order('category ASC') }
	belongs_to :restaurant
	validates :restaurants_id, presence: true
	validates :name, presence: true
	validates :price, presence: true
	validates :description, presence: true
	validates :category, presence: true
end
