class PagesController < ApplicationController
  before_filter :authenticate_user!, :only => [:game]
  def home
  end

  def game
  end

  def about
  end

  def ranking

    current_user.update_max_score(params[:diff],params[:score])

    #current_user.update_max_score(params[:diff],params[:score])

    #current_user.save!
    #current_user.save!
    
    @top_users = User.find_best("max_#{params[:diff]}")
    #User.order("max_#{params[:diff]}").reverse.first(5)


  end

end
