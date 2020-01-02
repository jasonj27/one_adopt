class Sender::UsersController < ApplicationController
  layout "sender"

  def edit
    @user = User.find(current_user.id)
  end

  def update
    form = Validsender.new(user_params)
    if !current_user.is_sender
      if form.validsender?
        current_user.update(is_sender: true)
        redirect_to sender_root_path, notice: "恭喜成為送養者！"
      else
        render :edit
      end
    elsif current_user.is_sender
      if form.validsender?
        current_user.update(user_params)
        redirect_to sender_root_path, notice: "更新成功！"
      else
        render :edit
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:sender_tel, :sender_add, :days, :w0, :w1, :w2, :w3, :w4, :w5, :w6)
  end
end
