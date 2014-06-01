class DineOut < ActiveRecord::Base
	default_scope{ order('created_at ASC') }
	belongs_to :restaurant
	validates :restaurants_id, presence: true
	validates :name, presence: true
	validates :phone_num, presence: true
	validates :kind, presence: true
	validates :meal, presence: true
end
