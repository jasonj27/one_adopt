class PagesController < ApplicationController
	before_action :authenticate_user!, except: [:login_page]
	
	def login_page
	end

	def index

	end

	

	def newfav
		@animals = Animal.all
	end



	private

	def user_login
		if not user_signed_in?
			redirect_to login_page
		end
	end
	
end
