class PagesController < ApplicationController
  def index
  end
	
	def newfav
		@animals = Animal.all
	end

end
