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
end
