module SessionsHelper

  def sign_in(restaurant)
    remember_token = Restaurant.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    restaurant.update_attribute(:remember_token, Restaurant.digest(remember_token))
    self.current_restaurant = restaurant
  end

  def signed_in?
  	!current_restaurant.nil?
  end

  def current_restaurant=(restaurant)
  	@current_restaurant = restaurant
  end

  def current_restaurant
  	remember_token = Restaurant.digest(cookies[:remember_token])
  	@current_restaurant ||= Restaurant.find_by(remember_token: remember_token)
  end

  def current_restaurant_id
    @current_restaurant_id = current_restaurant.id
  end

  def sign_out
    current_restaurant.update_attribute(:remember_token, 
      Restaurant.digest(Restaurant.new_remember_token))
    cookies.delete(:remember_token)
    self.current_restaurant = nil
  end
end
