class BaseController < ApplicationController
	before_action :permission_check!
	
	private
	def permission_check!
		if current_user.is_sender != 'true'
			redirect_to root_path, notice: '尚未成為送養者！'
		end
end