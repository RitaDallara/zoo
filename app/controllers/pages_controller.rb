class PagesController < ApplicationController
  before_filter :authenticate_user!, :only => [:game]
  respond_to :html, :js
  
  def home
    # the game options form contains values set by an admin
    @settings = Setting.first
  end

  def game
    # a game can be started only by correctly providing parameters
    if not(params[:num].present? && params[:diff].present?)
      redirect_to root_url
    end
  end

  def about
  end

  def ranking
    # the ranking is shown only after a game, and refers to that difficulty level
    if not (params[:diff].present? && params[:score].present?)
      redirect_to root_url
    elsif
      # we first update the user's max score (in the corresponding difficulty level)
      current_user.update_max_score(params[:diff],params[:score])
      # then we build up the ranking
      @top_users = User.find_best("max_#{params[:diff]}")
      @current_score = params[:score]
    end
  end

end
