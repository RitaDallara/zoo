class ErrorsController < ApplicationController
  respond_to :all # we don't mind what format the request that generated the error was
  
  def error_404
    @not_found_path = params[:not_found]
  end

  def error_500
  end
end
