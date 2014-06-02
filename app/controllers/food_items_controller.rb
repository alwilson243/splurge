class FoodItemsController < ApplicationController
	def index
		@food_items = FoodItem.all
	end

	def show
		@food_item = FoodItem.find(params[:id])
	end

	def new
		@food_item = FoodItem.new
	end

	def create
		@food_item = FoodItem.new(food_item_params)
		@food_item.restaurants_id = current_restaurant_id
		if @food_item.save
			redirect_to food_items_path, :notice => "Your item was saved!"
		else
			render "new"
		end
	end

	def edit
		@food_item = FoodItem.find(params[:id])
	end

	def update
		@food_item = FoodItem.find(params[:id])
		if @food_item.update_attributes(food_item_params)
			redirect_to food_items_path, :notice => "Item updated"
		else
			render "edit"
		end
	end

	def destroy
		@food_item = FoodItem.find(params[:id])
		@food_item.destroy
		redirect_to food_items_path, :notice => "Item deleted"
	end

	private

	def food_item_params
		params.require(:food_item).permit(:restaurants_id, :name,
			:category, :price, :description)
	end

end
