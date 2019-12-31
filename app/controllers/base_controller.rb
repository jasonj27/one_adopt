class BaseController < ApplicationController

  private
  def permission_check!
    if current_user.is_sender != 'true'
      redirect_to edit_sender_user_path, notice: '尚未成為送養者！'
    end
  end
end