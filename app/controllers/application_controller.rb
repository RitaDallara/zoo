class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?

#config.exceptions_app = self.routes
  
 # unless Rails.application.config.consider_all_requests_local
    #rescue_from CanCan::AccessDenied do |exception|
      #redirect_to main_app.root_url, :alert => exception.message
      #render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
    #end
    rescue_from CanCan::AccessDenied, with: lambda { |exception| render_error 403, exception}
    #rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
 # end
  
  
   protected
  
  def configure_permitted_parameters
     #devise_parameter_sanitizer.for(:sign_up) << :username
     # devise_parameter_sanitizer.for(:sign_up) do |u|
      #  u.require(:email)
       # u.require(:password)
        #u.require(:password_confirmation)
        #u.require(:username)
    #end
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
  end
    
   
      #def configure_devise_parameters
        #devise_parameter_sanitizer.for(:sign_up) do |u|
       #   u.permit(:email,:password, :password_confirmation,:username)
      #  end
     # end

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  
   private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end

end
