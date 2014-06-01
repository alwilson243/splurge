module FoodItemsHelper
	def current_food_item
		@current_food_item = FoodItem.where("restaurants_id = ?", current_restaurant.id)
	end
end
