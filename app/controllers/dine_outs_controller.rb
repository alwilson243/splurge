class DineOutsController < ApplicationController
	def index
		@dine_outs = DineOut.all
	end

	def show
		@dine_out = DineOut.find(params[:id])
	end

	def new
		@dine_out = DineOut.new
	end

	def create
		@dine_out = DineOut.new(dine_out_params)
		
		@dine_out.restaurants_id = current_restaurant_id
		
		respond_to do |format|
  		if @dine_out.save
  			redirect_to dine_outs_path, :notice => "Your order was saved!"
  		else
  			render "new"
  		end
		end
	end

	def edit
		@dine_out = DineOut.find(params[:id])
	end

	def update
		@dine_out = DineOut.find(params[:id])
		if @dine_out.update_attributes(dine_out_params)
			redirect_to dine_outs_path, :notice => "Order updated!"
		else
			render "edit"
		end
	end

	def destroy
		@dine_out = DineOut.find(params[:id])
		@dine_out.destroy
		redirect_to dine_outs_path, :notice => "Order deleted"
	end

	private

	def dine_out_params
		params.require(:dine_out).permit(:restaurants_id, :name, 
			:phone_num, :address, :type, :meal)
	end
end
