class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # def after_sign_in_path_for(admin_user)
  #   redirect_to admin_url
  # end

 
  private

  def confirm_logged_in
  	# unless session[:user_id]
  	# 	flash[:notice] = "Please Log In."
  	# 	redirect_to(:controller => 'access', :action => 'login')
  	# 	return false
  	# else
  	# 	return true
  	# end
  	
  end
end
