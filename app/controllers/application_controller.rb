class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # for devise
  def new_session_path(scope)
    new_user_session_path
  end
  helper_method :new_session_path
end
