class SearchesController < ApplicationController
  layout 'search'
  
  def simple
    search_conditions = Animal.search_kind(params[:animal_kind]).search_sex(params[:animal_sex]).search_age(params[:animal_age])

    data_array = []
    search_conditions.each do |search_condition|
      data_array << search_condition
    end

    @simple_search = data_array.sample(1)

    if user_signed_in?

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
    else
      if session[:a_list] == nil
        session[:a_list]= []
      else
        while session[:a_list].include?(@simple_search[0].id)
          @simple_search = data_array.sample(1)
    
          unless session[:a_list].include?(@simple_search[0].id)
            break
          end
        end
      end
      session[:a_list] << @simple_search[0].id
      session[:a_list] = [] if session[:a_list].count > ((data_array.count) - 1)
    end
  end
end
