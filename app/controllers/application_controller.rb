class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :update_accessed_at

  def update_accessed_at
    current_user.try(:touch, :accessed_at)
  end

  # for devise
  def new_session_path(scope)
    new_user_session_path
  end
  helper_method :new_session_path
end
