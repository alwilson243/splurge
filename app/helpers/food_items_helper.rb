module FoodItemsHelper
	def current_food_items
		@current_food_items = FoodItem.where("restaurants_id = ?", current_restaurant.id)
	end
end
