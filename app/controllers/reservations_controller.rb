class ReservationsController < ApplicationController
      def index   # home page of the blog
        if !signed_in?
          redirect_to login_page
          flash[:failure] = "Please Log In"
        else
          @reservations = Reservation.all
        end
      end
      
      def show    # shows an individual post (never called)
        @reservation = Reservation.find(params[:id])
      end

      def new     #  displays form to create a post
        if !signed_in?
          redirect_to login_page
          flash[:failure] = "Please Log In"
        else
          @reservation = Reservation.new
        end
      end

=begin
=end
      def create  # Handles creating the new post
        @reservation = Reservation.new(reservation_params)
        
        if current_restaurant_id != nil
         @reservation.restaurants_id = current_restaurant_id
        end
        
        respond_to do |format|
          if res_block_check(@reservation.restaurants_id, @reservation.time_start, @reservation.party_size) # Check time block
            if @reservation.save
              format.html { 
                redirect_to reservations_path, :notice => "Your reservation was saved!" 
              }
              format.json { 
                render :json => json_string_format("Accepted", @reservation.id.inspect, "Your reservation was saved!"),
                status: :created
              }
            else
              format.html { 
                render "new", 
                notice: "There was an error in the reservation" 
              }
              format.json { 
                render :json => json_string_format("Denied", "-1", "There was an error in the reservation"), 
                status: :unprocessable_entity
              }
            end
          else
            #Notify that there are no blocks left
            format.html {
              redirect_to reservations_path, :notice => @errmsg
            }
            format.json { 
              render :json => json_string_format("Denied", "-1", @errmsg)
            }
          end
        end
      end # the routine for creating a new reservation
            
      def edit    # form for editing the post
        if !signed_in?
          redirect_to login_page
          flash[:failure] = "Please log in"
        else
          @reservation = Reservation.find(params[:id])
        end
      end

      def update  # update submits changes to the database
        @reservation = Reservation.find(params[:id])
        oldTime = @reservation.time_start
        
        # displace original reservation out of block
        @reservation.update_attributes(:time_start => "2000-01-01 12:00:15") 
      
        editRes = Reservation.new(reservation_params)
        
        if res_block_check(current_restaurant_id, editRes.time_start, editRes.party_size)
          if @reservation.update_attributes(reservation_params)
            redirect_to reservations_path, :notice =>"Reservation Updated"
          else
            render "edit", :notice => "There was an error trying to save the reservation"
          end
        else
          @reservation.time_start = oldTime
          @reservation.save # revert the change to time and return the error
          redirect_to reservations_path, :notice => @errmsg
        end
        
    end

      def destroy # deletes the post
        @reservation = Reservation.find(params[:id])
        @reservation.destroy
        redirect_to reservations_path, :notice =>"Reservation Deleted"
      end 
     
=begin 
      NAME            : retrieve_status
      DESCRPITION     : Sends information about reservation
      PRE-CONDITIONS  : Requires that the user have a valid reservation ID number
      POST-CONDITIONS : Sends reservation data to the user

      RETURNS         : reservation information
      
      PARAMETERS      : 
                        
      TECHNICAL REQUIREMENTS: Retrieve data through HTML GET protocols
=end
     def retrieve_status
       
     end # of retrieve_status
     
     private
     status = ""
     def json_string_format(status, id, msg)
        return '{"messageType" : "ReservationResponse", "status" : "' << status <<
         '", "reservationID" : "' << id << '", "msg" : "' << msg << '"}'
     end # of json_string_format
     
     def reservation_params #specifies a post's attributes
         params.require(:reservation).permit(:restaurants_id, :name, :party_size, 
         	:time_start)
     end # of reservation_params

=begin
      NAME            : res_block_check
      DESCRPITION     : The method will check the amount of reservations in a particular block time
                        as well as three block times before and after block time, the method will 
                        also only accept quarter hour incremented time requests
      PRE-CONDITIONS  : User supplied data
      POST-CONDITIONS : The method will know if a reservation can be created with the time-block

      RETURNS         : boolean

      PARAMETERS      : id - the restaurant ID number for the reservation
                        mt - the meal_time provided by the patron, must be in quarter hour intervals, 
                             seconds must be zeroed 
                        ps - the party_size provided by the patron
      TECHNICAL REQUIREMENTS: This method requires that the individuals times are in discrete time blocks
=end
      def res_block_check(id, mt, ps)
          # Access database
          print "ENTERING ROUTINE WITH RESTAURANT ID: " << id.inspect <<  " AND " << "PARTY_SIZE: " << ps.inspect << "\n"

          if (mt == nil || ps == nil) # this block checks to see if any of the parameters are nil
            @errmsg = "You must fill in all required fields"
            return false
          end

          # Check for value minute intervals and zeroed seconds
          if (mt.min == nil || mt.min % 15 != 0) # minutes invalidation check
            @errmsg = "Minutes are invalid for reservation input"
            return false
          end
          if (mt.sec != 0) # seconds invalidation check
            @errmsg = "Seconds are invalid for reservation input"
            return false
          end
          
          if (ps == nil || ps <= 0) # Check for real party sizes
            @errmsg = "A party consists of one or more people."
            return false
          end
          
          # Add code for open hours and auto reject if invalid hours are used
 
          # Acquire reservation block counter
          restaurant = Restaurant.find(id)
          timeBlock = (restaurant.reserveCap == nil)? 4 : restaurant.reserveCap # Restaurant.find(params[:restaurants_id]).reserveCap
          print "Restaurant reservation cap per block is : " << timeBlock.inspect << "\n"
          tableCapacity = 4 # will subtract from timeBlock via equation (timeBlock - (tableCapacity/timeBlock))
          requestingSize = (Float(ps)/tableCapacity).ceil
          
          print "Client is requesting a table of size: " << requestingSize.ceil.inspect << "\n"
          
           timeBlocksTaken = 0 # check how many blocks have already been consumed
           
           
          -2700.step(2700, 900){ # 60 seconds * 15 * 3 = 2700 -> from 1hr before to 1hr after resv
              |i| puts i
            @res = Reservation.where("restaurants_id = ? AND time_start = ? ", id, (mt + i))
            print "Found a total of " << @res.size.inspect << " records corresponding the ID...\n\n\n"
            
            @res.each do |res|
              timeBlocksTaken += (Float(res.party_size)/tableCapacity).ceil
            end
            if (timeBlock) < (timeBlocksTaken + requestingSize)
              @errmsg = "Sorry! All reservations for that time block are filled"
              return false
            end
          }
          return true
      end # res_block_check routine
end
