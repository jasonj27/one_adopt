class Sender::UsersController < ApplicationController
  layout "sender"

  def edit
    @user = User.find(current_user.id)
  end

  def update
    form = Validsender.new(user_params)
    if !current_user.is_sender
      if form.validsender?
        params[:user][:sender_add] = params[:user][:sender_area] + params[:user][:sender_add]

        current_user.update(is_sender: true)
        current_user.update(user_params.except(:sender_area))

        redirect_to sender_root_path, notice: "恭喜成為送養者！"
      else
        render :edit
      end
    elsif current_user.is_sender
      if form.validsender?
        params[:user][:sender_add] = params[:user][:sender_area] + params[:user][:sender_add]

        current_user.update(user_params.except(:sender_area))
        redirect_to sender_root_path, notice: "更新成功！"
      else
        render :edit
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:sender_tel, :sender_add, :sender_area, :days, :w0, :w1, :w2, :w3, :w4, :w5, :w6, :readme, :latitude, :longtitude)
  end
end
