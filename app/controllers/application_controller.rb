class ApplicationController < ActionController::Base
  def current_user
    cookies[:user_id].try { |id| User.includes(:organization).find_by(id:) }
  end
end
