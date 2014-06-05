class RestaurantsController < ApplicationController
  def new
  	@restaurant = Restaurant.new
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    if(@restaurant.id != current_restaurant.id)
      redirect_to @current_restaurant
    end
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
    if(@restaurant.id == current_restaurant.id)
      flash[:success] = "you are editing your restaurant"
    else # prevents you from editing other restaurants info
      flash[:failure] = "this is where you belong, bastard"
      redirect_to @current_restaurant
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(user_params)
      redirect_to restaurant_path, :notice => "Your information was saved!"
    else
      render "edit"
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
      names << '{"name" : "' << r.name << '", "id" : "' << r.id.inspect << '", "icon" : ""' << '' << '}'
    end
    render :json => '{"messageType" : "InformationResponse", "request" : "RestaurantList", "list" : [' << names << ']}'
  end
  
  #needs error checking!!
  #needs to follow the JSON-Thomas Doctorine, provided in the collaborative google drive document
  #needs commenting
  def info_restaurant
    @restaurant = Restaurant.find(params[:restaurant_Id])
    render :json => 
    '{
      "messageType" : "InformationResponse", 
      "request" : "Restaurant", 
      "restaurantId" : "' << @restaurant.id.inspect << '",
      "restaurantName" : "' << @restaurant.name << '",
      "restaurantLocation" : "' << @restaurant.address << '",
      "restaurantMenu" : [' << menu_string_generator(@restaurant.id) << '],
      "restaurantHours" : [
        {"dayNum" : "0",
        "startTime" : "' << @restaurant.sundayOpen.to_s(:time) << '",
        "endTime" : "' << @restaurant.sundayClose.to_s(:time) << '"},
        {"dayNum" : "1",
        "startTime" : "' << @restaurant.mondayOpen.to_s(:time) << '",
        "endTime" : "' << @restaurant.mondayClose.to_s(:time) << '"},
        {"dayNum" : "2",
        "startTime" : "' << @restaurant.tuesdayOpen.to_s(:time) << '",
        "endTime" : "' << @restaurant.tuesdayClose.to_s(:time) << '"},
        {"dayNum" : "3",
        "startTime" : "' << @restaurant.wednesdayOpen.to_s(:time) << '",
        "endTime" : "' << @restaurant.wednesdayClose.to_s(:time) << '"},
        {"dayNum" : "4",
        "startTime" : "' << @restaurant.thursdayOpen.to_s(:time) << '",
        "endTime" : "' << @restaurant.thursdayClose.to_s(:time) << '"},
        {"dayNum" : "5",
        "startTime" : "' << @restaurant.fridayOpen.to_s(:time) << '",
        "endTime" : "' << @restaurant.fridayClose.to_s(:time) << '"},
        {"dayNum" : "6",
        "startTime" : "' << @restaurant.saturdayOpen.to_s(:time) << '",
        "endTime" : "' << @restaurant.saturdayClose.to_s(:time) << '"}
      ]}'
  end

  private
    def menu_string_generator(id)
      str = ""
      ["Breakfast", "Lunch", "Dinner", "Dessert", "Beverage"].each do |category|
        if str != ""
          str += ',{'
        else
          str += '{'
        end
        str += '
            "title" : "' << category << '",
            "items" : ['
        @food_items = FoodItem.where("restaurants_id = ? AND category = ?", id, category)
        @food_items.each do |food_item|
          str += '
            {"itemName" : "' << food_item.name << '",
            "price" : "' << food_item.price.inspect << '",
            "itemDescription" : "' << food_item.description << '"}'
        end
        str += ']}'
      end
      return str
    end
    #def user_params
     # params.require(:restaurant).permit(:name, :owner, :phone, 
      #  :address, :password, :password_confirmation)
    #end
    #=========
    def user_params
      params.require(:restaurant).permit(:name, :owner, :phone, 
        :address, :reserveCap, :sundayOpen, :sundayClose, :mondayOpen, 
        :mondayClose, :tuesdayOpen, :tuesdayClose, :wednesdayOpen,
        :wednesdayClose, :thursdayOpen, :thursdayClose, :fridayOpen,
        :fridayClose, :saturdayOpen, :saturdayClose, :password, 
        :password_confirmation)
    end
end
