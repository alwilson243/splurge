class ReservationsController < ApplicationController
      def index   # home page of the blog
        @reservations = Reservation.all
      end
      
      def show    # shows an individual post (never called)
        @reservation = Reservation.find(params[:id])
      end

      def new     #  displays form to create a post
        @reservation = Reservation.new
      end

      def create  # Handles creating the new post
        @reservation = Reservation.new(reservation_params )

        if @reservation.save
          redirect_to reservations_path, :notice => "Your reservation was saved!"
        else
          render "new"
        end
      end

      def edit    # form for editing the post
        @reservation = Reservation.find(params[:id])
      end

      def update  # update submits changes to the database
        @reservation = Reservation.find(params[:id])
          if @reservation.update_attributes(reservation_params)
            redirect_to reservations_path, :notice =>"Reservation updated"
          else
            render "edit"
          end
      end

      def destroy # deletes the post
        @reservation = Reservation.find(params[:id])
        @reservation.destroy
        redirect_to reservations_path, :notice =>"Reservation deleted"
      end 
     
     private

     def reservation_params #specifies a post's attributes
         params.require(:reservation).permit(:restaurants_id, :name, :party_size, 
         	:meal_time)
     end

end
