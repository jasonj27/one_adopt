class SearchesController < ApplicationController
  before_action :authenticate_user!

  layout 'search'
  
  def show
    @animal = Animal.find(params[:id])
  end

  def simple
      animals = Animal.where.not(adopt_status: "已領養")
                            .search_kind(params[:animal_kind])
                            .search_sex(params[:animal_sex])
                            .search_age(params[:animal_age])

      ids = animals.joins(:favorites)
                   .where("favorites.user_id = ?", current_user.id)
                   .pluck(:id)

      search_params = animals.where.not(id: ids)                            

    if search_params.empty?
      redirect_to searches_path, notice: '沒有匹配的資料！'
    else
      simple_sample(search_params)
    end
  end

  def advance
    search_params = Animal.where.not(adopt_status: "已領養")
                                .search_kind(params[:animal_kind])
                                .search_sex(params[:animal_sex])
                                .search_age(params[:animal_age])
                                .search_sterilization(params[:animal_sterilization])
                                .search_area_pkid(params[:animal_area_pkid])
                                .search_shelter(params[:animal_shelter])
                                .page(params[:page]).per(8)
    
    if search_params.empty?
      redirect_to searches_path, notice: '沒有匹配的資料！'
    else
      @search_params = search_params
    end
  end

  private
  def simple_sample(search_params)
    data_array = []
    search_params.each do |s|

      data_array << s
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
end