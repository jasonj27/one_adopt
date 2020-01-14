class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites.includes({ animal: :user }, :animal)
    @favorites_group = @favorites.group_by { |i| i.animal.user.name }
    
    redirect_to root_path, notice: '趕快去搜尋寵物，進行收藏吧！' if @favorites.empty?
  end

  def destroy
    current_user.favorites.find_by(animal_id: "#{params[:id]}").destroy
    redirect_to favorites_path
  end

  def destroy_all
  end
end


