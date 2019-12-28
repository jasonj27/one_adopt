class RegistrationsController < Devise::RegistrationsController
	#繞過修改資料需要輸入密碼
	private
	def update_resource(resource, params)
      # Require current password if user is trying to change password.
      return super if params["password"]&.present?
  
      # Allows user to update registration information withoutpassword.
      resource.update_without_password(params.except("current_password"))
  end
end
