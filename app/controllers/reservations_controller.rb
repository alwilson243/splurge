class ReservationsController < ApplicationController
      def index   # home page of the blog
      	@reservations = Reservation.all
      end

      def show    # shows an individual post

      end

      def new     #  displays form to create a post

      end

      def create  # Handles creating the new post

      end

      def edit    # form for editing the post

      end

      def update  # update submits changes to the database

      end

      def destroy # deletes the post

      end 
     
     private

     def post_params #specifies a post's attributes
         params.require(:reservation).permit(:name, :party_size, 
         	:meal_time)
     end

end
