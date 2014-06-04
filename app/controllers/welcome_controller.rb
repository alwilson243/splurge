class WelcomeController < ApplicationController
	def index
		if signed_in?
			redirect_to @current_restaurant
		end
	end
end
