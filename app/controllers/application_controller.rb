class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  def set_current_user
    @current_user = current_user
  end

  def current_user
    @current_user ||= current_user_from_session || current_user_from_cookie
  end

  def current_user_from_session
    User.find_by(id: session[:user_id])
  end

  def current_user_from_cookie
    User.find_by(id: cookies.encrypted[:user_id])
  end
end
