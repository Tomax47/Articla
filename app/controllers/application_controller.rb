class ApplicationController < ActionController::Base
  helper_method :current_user


  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

  def ensure_current_user
    if current_user.nil?
      redirect_to users_new_path
    end
  end

end
