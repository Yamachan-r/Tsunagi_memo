class SessionsController < ApplicationController
  skip_before_action :require_login

  def create
    user_info = request.env["omniauth.auth"]
    hashed_uid = User.hash_uid(user_info["uid"]) # UIDをハッシュ化
  
    # ハッシュ化されたUIDでユーザーを検索または作成
    user = User.find_or_create_by(hashed_uid: hashed_uid) do |u|
      u.name = user_info["info"]["name"]
    end

    # セッションにユーザーIDを保存
    session[:user_id] = user.id
    redirect_to family_groups_path, notice: "ログインしました"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
