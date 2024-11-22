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

    # 保留中の招待があれば処理
    if session[:pending_invite_token].present?
      handle_pending_invite
    else
    redirect_to root_path, notice: "ログインしました"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "ログアウトしました"
  end

  private

  def handle_pending_invite
    family_group = FamilyGroup.find_by(invite_token: session[:pending_invite_token])
    if family_group
      current_user.family_groups << family_group unless current_user.family_groups.include?(family_group)
      session.delete(:pending_invite_token)
      redirect_to family_group_path(family_group), notice: "ログインしてグループに参加しました。"
    else
      session.delete(:pending_invite_token)
      redirect_to family_groups_path, alert: "無効な招待リンクです。"
    end
  end
end
