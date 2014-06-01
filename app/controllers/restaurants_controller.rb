class RestaurantsController < ApplicationController
  def new
  	@restaurant = Restaurant.new
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def create
  	@restaurant = Restaurant.new(user_params)
  	if @restaurant.save
      sign_in @restaurant
      flash[:success] = "Successful Registration"
  	  redirect_to @restaurant
  	else
  	  render 'new'
  	end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(restaurant_params)
      redirect_to restaurants_path, :notice => "Information updated!"
    else
      render "edit"
    end
  end

  private

    def user_params
      params.require(:restaurant).permit(:name, :owner, :phone, 
        :address, :password, :password_confirmation)
    end
end
