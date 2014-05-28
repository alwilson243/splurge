module DineOutsHelper
  def current_dine_outs
    @current_dine_outs = DineOut.where("restaurants_id = ?", current_restaurant.id)
  end
end
