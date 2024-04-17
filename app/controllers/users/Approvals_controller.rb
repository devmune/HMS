class ApprovalsController < Devise::RegistrationsController
 def create
    build_resource(sign_up_params)
    if resource.save
      if resource.pending_approval?
        flash[:notice] = "You have successfully signed up! Your account is pending approval."
        redirect_to new_user_session_path
      else
        flash[:notice] = "You have successfully signed up! Please log in."
        redirect_to new_user_session_path
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render :new
    end
 end
end