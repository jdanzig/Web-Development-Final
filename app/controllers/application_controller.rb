class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :logged_out?
private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def logged_in?
    !!current_user
  end

  def logged_out?
    !current_user
  end

  def require_login
    unless logged_in?
      flash[:alert] = 'You must be logged in to access this page.'
      redirect_to login_path
    end
  end

  def deny_access
    if logged_out?
      require_login
    else
      flash[:alert] = "Insufficient permissions."
      redirect_to root_path
    end
  end


  def require_logout
    unless logged_out?
      flash[:alert] = 'You must be logged out to access this page.'
      redirect_to root_path
    end
  end

end
