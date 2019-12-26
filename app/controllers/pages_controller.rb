class PagesController < ApplicationController
	
	def index
<<<<<<< HEAD
		
=======
		# render html: 'show page'
>>>>>>> add login check in favorites pages searches controllers
		# redirect_to newfav_pages_path
	end

	def newfav
		@animals = Animal.all
	end

end
