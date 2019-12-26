class FavoritesController < ApplicationController
	before_action :authenticate_user!

	def index
	  @favorites = current_user.favorites.includes({animal: :user}, :animal)
	  @sort_fav={}
	  @favorites.each do |fav|
	    if @sort_fav.has_key?(fav.animal.user.name)
	      @sort_fav[fav.animal.user.name]['animals'].push([fav.animal.name, fav.animal.id])
	    else
	      @sort_fav.store(fav.animal.user.name , {'id'=> fav.animal.user.id, 'animals'=> [[fav.animal.name, fav.animal.id]]})
	    end
	  end
	end

end
