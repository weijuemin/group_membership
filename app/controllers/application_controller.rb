class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def current_user
    User.find(session[:id]) if session[:id]
  end
  helper_method :current_user

  def require_login
    if not session[:id]
      redirect_to "/"
    end
  end

  def logged_in
    session[:id] == nil ? false : true
  end
end
