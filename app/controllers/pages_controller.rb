class PagesController < ApplicationController
  respond_to :html, :js
  def home
  end

  def game
    respond_to do |format|
      #format.html {}
      format.js
    end
  end

  def about
  end
end
