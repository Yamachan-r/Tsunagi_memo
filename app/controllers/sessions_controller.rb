class SessionsController < ApplicationController
  skip_before_action :require_login

  def create
    user_info = request.env["omniauth.auth"]
    user = User.find_or_create_by(uid: user_info["uid"]) do |u|
      u.name = user_info["info"]["name"]
    end
    session[:user_id] = user.id
    redirect_to family_groups_path, notice: "ログインしました"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
