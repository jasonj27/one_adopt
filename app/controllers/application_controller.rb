class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(users)
    if session[:not_login_favorite].nil?
      pages_path
    elsif (Time.zone.now - session[:not_login_favorite][:created_at].to_time) > 300
      update_favorite_animal_and_nil_session
      pages_path
    else
      update_favorite_animal_and_nil_session
      search_path(id: @id)
    end
    
  end

  def after_sign_out_path_for(users)
    landingpage_pages_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def update_favorite_animal_and_nil_session
    @id = session[:not_login_favorite][:share_animal_id]
    favorites = current_user.favorites.map{ |f| f.animal_id }.include?(@id)
    current_user.favorites.create(animal_id: @id) if !favorites
    session[:not_login_favorite] = nil
  end
end
