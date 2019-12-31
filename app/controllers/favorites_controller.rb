class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites.includes({ animal: :user }, :animal)
    @sort_fav = {}
    @favorites.each do |fav|
      if @sort_fav.has_key?(fav.animal.user.name)
        @sort_fav[fav.animal.user.name]["animals"].push([fav.animal.name, fav.animal.id, fav.animal.animal_kind, fav.animal.animal_age])
      else
        @sort_fav.store(fav.animal.user.name, { "id" => fav.animal.user.id,
                                               "animals" => [[fav.animal.name, fav.animal.id, fav.animal.animal_kind, fav.animal.animal_age]] })
      end
    end
  end

  def destroy
    current_user.favorites.find_by(animal_id: "#{params[:id]}").destroy
    redirect_to testfav_reservations_path
  end
end
