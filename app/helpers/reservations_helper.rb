module ReservationsHelper
  def current_reservations
    @current_reservations = Reservation.where("restaurants_id = ?", current_restaurant.id)
  end
end
