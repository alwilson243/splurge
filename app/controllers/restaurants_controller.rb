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
  
  def list_restaurants
    # Don't remove, output for the continued prosterity of "Steeley Dan"
    print "Bad sneakers and a pina colada my friend, walking down the avenue to radio city, with a transistor and a large sum of money to spend\n"
    @restaurant = Restaurant.all
    names = ""
    @restaurant.each do |r|
      if names != "" 
        names << ", "
      end
      names << '{"name" : "' << r.name << '", "id : "' << r.id.inspect << ', "icon" : ' << '' << '}'
    end
    render :json => '{"messageType" : "InformationResponse", "request" : "RestaurantList", "list" : [' << names << ']}'
  end
  
  #needs error checking!!
  #needs to follow the JSON-Thomas Doctorine, provided in the collaborative google drive document
  #needs commenting
  def info_restaurant
    @restaurant = Restaurant.find(params[:restaurant_Id])
    render :json => '{"messageType" : "InformationResponse", "request" : "Restaurant", "restaurantId" : "' << 
    @restaurant.id.inspect << '", "restaurantName" : "' << @restaurant.name << 
    '""}'
  end

  private

    def user_params
      params.require(:restaurant).permit(:name, :owner, :phone, 
        :address, :password, :password_confirmation)
    end
end
