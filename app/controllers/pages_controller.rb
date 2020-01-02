class PagesController < ApplicationController
  layout "search", only: :index

  def index
  end

  def introduction
    if !current_user.nil?
      redirect_to pages_path
    end
  end

  def newfav
    @animals = Animal.all
  end

  def landingpage
  end
end
