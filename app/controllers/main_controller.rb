class MainController < ApplicationController
  def index
    if current_user.nil?
      superuser = User.find_by!(role: "root")
      return redirect_to login_path(user_id: superuser.id)
    end

    @users = User.all.includes(:organization)
    @current_user = current_user
    @total_videos = Video.count

    available_videos = Video
      .includes(:distribution_setting, author: [:organization])
      .available_for(current_user)
      .order(:name)

    # add allowed actions to each video so view can decide which buttons to render
    @videos = available_videos.each do |video|
      video.allowed_actions = AUTHORIZER.allowed_actions(current_user, video)
    end
  end

  def login
    cookies[:user_id] = params[:user_id]
    redirect_to root_path
  end
end
