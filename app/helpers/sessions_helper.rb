module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id # thanks to SessionsHelper
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) # only do this once per request
  end

  # Returns true if the user is logged in
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
