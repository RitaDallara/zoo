class PagesController < ApplicationController
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
    
    @top_users = User.order("max_#{params[:diff]}").first(5)


  end

end
