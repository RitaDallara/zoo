class PagesController < ApplicationController
  def home
  end

  def game
  end

  def about
  end

  def ranking
    @username= current_user.username

    @current_user = current_user
    @current_user.update_max_score(params[:diff],params[:score])

    #current_user.update_max_score(params[:diff],params[:score])

    @current_user.save!
    #current_user.save!

    @score = current_user.max_easy


  end

end
