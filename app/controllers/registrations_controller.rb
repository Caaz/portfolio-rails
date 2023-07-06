class RegistrationsController < Devise::RegistrationsController

    before_action :one_admin_registered?, only: [:new, :create]
    
    protected
  
    def one_admin_registered?
      if Admin.count == 1
        if user_signed_in?
          redirect_to root_path
        else
          redirect_to new_user_session_path
        end
      end  
    end
  
  end