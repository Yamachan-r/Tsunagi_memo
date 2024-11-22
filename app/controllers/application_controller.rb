class ApplicationController < ActionController::Base
  # Rails7.2標準化されているブラウザ制限をコメントアウト
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  before_action :require_login
  helper_method :current_user

  def require_login
    redirect_to root_path, alert: "不正アクセスです。ログインしてください。" unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def validate_group_membership(group_id, user_id)
    # グループが存在し、ログインユーザーが所属しているかを確認
    family_group = current_user.family_groups.find_by(id: group_id)
    unless family_group
      redirect_to family_groups_path, alert: '不正なアクセスです。'
      return false
    end

    # グループに属しているユーザーか確認
    user = family_group.users.find_by(id: user_id)
    unless user
      redirect_to family_group_path(group_id), alert: 'このユーザーの情報を見る権限がありません。'
      return false
    end

    true
  end
end
