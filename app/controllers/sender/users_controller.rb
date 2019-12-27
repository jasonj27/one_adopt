class Sender::UsersController < ApplicationController
  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to sender_root_path, notice: '更新成功'
    else
      render :edit
    end

  end

  private
  def user_params
    params.require(:user).permit(:sender_tel, :sender_add, :days,:w0, :w1, :w2, :w3, :w4, :w5, :w6)
  end

end
