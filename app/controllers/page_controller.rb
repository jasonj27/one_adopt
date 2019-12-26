class PagesController < ApplicationController
	
	def newfav
		@animals = Animal.all
	end

end
