class SearchesController < ApplicationController
  before_action :authenticate_user!

  layout 'search'
  
  def show
    @animal = Animal.find(params[:id])
  end

  def simple
    search_conditions = Animal.search_kind(params[:animal_kind])
                              .search_sex(params[:animal_sex])
                              .search_age(params[:animal_age])

    data_array = []
    search_conditions.each do |search_condition|
      data_array << search_condition
    end

    @simple_search = data_array.sample(1)

    current_user.search_session.map! { |x| x.to_i }
    while current_user.search_session.include?(@simple_search[0].id)
      @simple_search = data_array.sample(1)

      unless current_user.search_session.include?(@simple_search[0].id)
        break
      end
    end
    current_user.search_session << @simple_search[0].id
    current_user.search_session = [] if current_user.search_session.count > ((data_array.count) - 1) 
    current_user.save
  end

  def advance
    @search_conditions = Animal.search_kind(params[:animal_kind])
                               .search_sex(params[:animal_sex])
                               .search_age(params[:animal_age])
                               .search_sterilization(params[:animal_sterilization])
                               .search_area_pkid(params[:animal_area_pkid])
                               .search_shelter(params[:animal_shelter])
                               .page(params[:page]).per(8)
  end
end
