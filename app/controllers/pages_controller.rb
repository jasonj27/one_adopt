class PagesController < ApplicationController
	before_action :authenticate_user!, except: [:login_page]
	
	def login_page
		@user = current_user
	end

	def index

	end

	

	def newfav
		@animals = Animal.all
	end

end
