class PagesController < ApplicationController
	
	def index
		render html: 'show page'
		# redirect_to newfav_pages_path
	end

	def newfav
		@animals = Animal.all
	end

end
