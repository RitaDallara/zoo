class PagesController < ApplicationController
  respond_to :html, :js
  
  before_filter :authenticate_user!, :only => [:game]
  
  def home
  end

  def game
    if not(params[:num].present? && params[:diff].present?)
      redirect_to root_url
    end
  end

  def about
  end

  def ranking
    if not (params[:diff].present? && params[:score].present?)
      redirect_to root_url
    elsif
      current_user.update_max_score(params[:diff],params[:score])
      @top_users = User.find_best("max_#{params[:diff]}")
    end
  end

end
