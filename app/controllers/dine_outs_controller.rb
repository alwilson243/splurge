class DineOutsController < ApplicationController
	def index
		if !signed_in?
      		redirect_to login_page
      		flash[:failure] = "Please log in"
    	else
			@dine_outs = DineOut.all
		end
	end

	def show
		@dine_out = DineOut.find(params[:id])
	end

	def new
		if !signed_in?
      		redirect_to login_page
      		flash[:failure] = "Please log in"
    	else
			@dine_out = DineOut.new
		end
	end

	def create
		@dine_out = DineOut.new(dine_out_params)
		
		if current_restaurant_id != nil
  		@dine_out.restaurants_id = current_restaurant_id
		end
		
		respond_to do |format|
  		if @dine_out.save
  		  format.html{redirect_to dine_outs_path, :notice => "Your order was saved!"}
  		  format.json{render :json => json_string_format("Accepted", @dine_out.id.inspect, "Your order was saved!!!!")}
  		else
  			format.html{render "new", :notice => "There was a mistake in your order!"}
  			format.json{
  			  render :json => json_string_format("Denied", "-1", "Your order could not be any more invalid."),
  			  status: :unprocessable_entity
  			}
  		end # saving condition
		end # respond loop
	end

	def edit
		if !signed_in?
      		redirect_to login_page
      		flash[:failure] = "Please log in"
    	else
			@dine_out = DineOut.find(params[:id])
		end
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
   def json_string_format(status, id, msg)
      return '{"messageType" : "dineout", "status" : "' << status <<
       '", "dineout_id" : "' << id << '", "msg" : "' << msg << '"}'
   end # of json_string_format
   
	def dine_out_params
		params.require(:dine_out).permit(:restaurants_id, :name, 
			:phone_num, :address, :kind, :meal, :time_gimme)
	end
end
