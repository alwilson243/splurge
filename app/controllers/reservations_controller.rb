class ReservationsController < ApplicationController
      def index   # home page of the blog
      	@reservations = Reservation.all
      end

      def show    # shows an individual post
        @reservation = Reservation.find(params[:id])
      end

      def new     #  displays form to create a post
        @reservation = Reservation.new
      end

      def create  # Handles creating the new post
        @reservation = Reservation.new(params.require(:reservation).permit(
          :name, :party_size, :meal_time))

        if @reservation.save
          redirect_to reservations_path, :notice => "Your reservation was saved!"
        else
          render "new"
        end
      end

      def edit    # form for editing the post
        @post = Post.find(params[:id])
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
