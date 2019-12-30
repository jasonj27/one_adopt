class PagesController < ApplicationController
	layout 'search', only: :index

	def index
	end

	def newfav
		@animals = Animal.all
	end

	def landingpage
	end
end
