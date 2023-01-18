class ApplicationController < ActionController::Base
  def current_user
    cookies[:user_id].try { |id| User.find_by(id:) }
  end
end
