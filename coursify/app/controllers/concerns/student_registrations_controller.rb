class StudentRegistrationsController < Devise::RegistrationsController
    before_filter :prevent_sign_up, only: [:new, :show, :index, :destroy]
    before_filter :configure_permitted_parameters
	protected

    def prevent_sign_up
        redirect_to enroll_path and return
    end
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update).push(:name)
      devise_parameter_sanitizer.for(:sign_up).push(:name)
    end
end