class PagesController < ApplicationController
  def home
  end

  def game
    @num_quiz= params[:num]
  end

  def about
  end
end
