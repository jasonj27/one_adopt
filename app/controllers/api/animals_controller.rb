class Api::AnimalsController < ApplicationController

	def favorite
		animal = Animal.find(params[:id])
		fav = Favorite.find_by(user: current_user,animal: animal)
		favorited = false

		if fav
			fav.destroy
		else
			current_user.favorites.create(animal: animal) #Request failed with status code 500
			favorited = true
		end

  render json: { status:'ok', favorited: favorited } #true or false
	

	end
 
end
