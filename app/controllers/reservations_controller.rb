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

=begin
=end
      def create  # Handles creating the new post
        @reservation = Reservation.new(reservation_params)
        
        respond_to do |format|
          if res_block_check(@reservation.restaurants_id, @reservation.timeStart) # Check time block
            if @reservation.save
              format.html { 
                redirect_to reservations_path, :notice => "Your reservtion was saved!" 
              }
              format.json { 
                render :json => '{"pass?" : "true", "resv_id" : "' << @reservation.id.inspect << '", "msg: "Reservation made!"}',
                status: :created
              }
            else
              format.html { 
                render "new", 
                notice: "There was an error in the reservation" 
              }
              format.json { 
                render :json => '{"pass?" : "false", "resv_id" : "-1", "msg" : "Error in reservation"}', 
                status: :unprocessable_entity
              }
            end
          else
            #Notify that there are no blocks left
            format.html {
              redirect_to reservations_path, :notice => "Sorry! All reservations for that time block are filled"
            }
            format.json { 
              render :json => '{"pass?" : "false", "resv_id" : "-1", "msg" : "All reservations are filled."}'
            }
          end
        end
      end # the routine for creating a new reservation
            
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
     
=begin 
      NAME            : retrieve_status
      DESCRPITION     : 
      PRE-CONDITIONS  : 
      POST-CONDITIONS : 

      RETURNS         : void
      
      PARAMETERS      : 
                        
      TECHNICAL REQUIREMENTS: Retrieve data through HTML GET protocols
=end
     def retrieve_status
       
     end
     
     private

     def reservation_params #specifies a post's attributes
         params.require(:reservation).permit(:restaurants_id, :name, :party_size, 
         	:timeStart)
     end

=begin
      NAME            : res_block_check
      DESCRPITION     : The method will check the amount of reservations in a particular block time
      PRE-CONDITIONS  : User supplied data
      POST-CONDITIONS : The method will know if a reservtation can be created with the time-block

      RETURNS         : boolean

      PARAMETERS      : id - the restaurant ID number for the reservation
                        mt - the meal_time provided by the patron  
                        
      TECHNICAL REQUIREMENTS: This method requires that the individuals times are in discrete time blocks
=end
      def res_block_check(id, mt)
          # Access database
          print "ENTERING ROUTINE WITH RESTAURANT ID: " << id.inspect <<  "...\n"
          @res = Reservation.where("restaurants_id = ? AND timeStart = ?", id, mt)
          print "Found a total of " << @res.size.inspect << " records corresponding the ID...\n\n\n"
          # Acquire reservation block counter
          timeBlock = 4 # Restaurant.find(params[:restaurants_id]).time_per_block
          #tableCapacity = 4 # will subtract from timeBlock via equation (timeBlock - (tableCapacity/timeBlock))
          if @res.size < timeBlock
            return true
          end
          return false
      end # res_block_check routine
end
