class RegistrationsController < Devise::RegistrationsController
    before_filter :prevent_sign_up, only: [:new, :create, :show, :index, :destroy]
    before_filter :configure_permitted_parameters
	protected

    def prevent_sign_up
    	if current_admin_user
    		
    	else
	      flash[:notice] = "Please Sign in"
	      redirect_to new_admin_user_session_path and return
	    end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update).push(:name)
      devise_parameter_sanitizer.for(:sign_up).push(:name)
    end
end
