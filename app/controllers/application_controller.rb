class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?

   protected
  
  def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) << :username
     # devise_parameter_sanitizer.for(:sign_up) do |u|
      #  u.require(:email)
       # u.require(:password)
        #u.require(:password_confirmation)
        #u.require(:username)
    #end
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

end
