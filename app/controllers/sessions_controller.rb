class SessionsController < ApplicationController

  def new
  	render 'new'
  end

  def create 
    restaurant = Restaurant.find_by(name: params[:session][:name].downcase)
    if restaurant && restaurant.authenticate(params[:session][:password])
      sign_in restaurant
      redirect_to restaurant
    else
      flash.now[:error] = "bad login"
      render 'new'
    end
  end

  def delete
    sign_out
    redirect_to root_url
  end
end
