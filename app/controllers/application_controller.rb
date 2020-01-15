class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(users)
    if session[:share_animal_id].nil?
      pages_path
    else
      id = session[:share_animal_id]
      favorites = current_user.favorites.map{ |f| f.animal_id }.include?(id)
      current_user.favorites.create(animal_id: id) if !favorites

      session[:share_animal_id] = nil
      search_path(id: id)
    end
    
  end

  def after_sign_out_path_for(users)
    landingpage_pages_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
