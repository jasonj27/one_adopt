class PagesController < ApplicationController
	
	def index
		
		# redirect_to newfav_pages_path
	end

	def newfav
		@animals = Animal.all
	end

	def landingpage
		
	end
end
