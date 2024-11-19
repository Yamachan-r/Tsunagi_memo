class FamilyGroupsController < ApplicationController
  before_action :set_family_group, only: [:show, :invite_member, :generate_invite]
  before_action :authorize_family_group, only: [:show, :invite_member, :generate_invite]
  skip_before_action :require_login, only: %i[join]

  def index
    @family_groups = current_user.family_groups
  end

  def show
    @members = @family_group.users
  end

  def new
    @family_group = FamilyGroup.new
  end

  def create
    @family_group = FamilyGroup.new(family_group_params)
    if @family_group.save
      redirect_to family_groups_path, notice: "グループが作成されました。"
      current_user.family_groups << @family_group
    else
      render :new
    end
  end

  def invite_member
    user = User.find_by(email: params[:email])
    if user
      @family_group.users << user
      redirect_to @family_group, notice: 'メンバーが招待されました。'
    else
      redirect_to @family_group, alert: 'ユーザーが見つかりません。'
    end
  end

  def generate_invite
    @family_group.generate_invite_token
    @invite_url = join_family_group_url(@family_group.invite_token)
    redirect_to family_group_path(@family_group), notice: '招待リンクが生成されました！'
  end

  def join
    @family_group = FamilyGroup.find_by(invite_token: params[:token])
    if @family_group
      if current_user
        current_user.family_groups << @family_group unless current_user.family_groups.include?(@family_group)
        redirect_to @family_group, notice: 'グループに参加しました。'
      else
        # セッションに招待トークンを保存
        session[:pending_invite_token] = params[:token]
        redirect_to '/auth/line', notice: 'グループに参加するにはログインしてください。'
      end
    else
      redirect_to root_path, alert: '無効な招待リンクです。'
    end
  end

  private

  def family_group_params
    params.require(:family_group).permit(:name)
  end

  def set_family_group
    @family_group = FamilyGroup.find(params[:id])
  end

  def authorize_family_group
    unless current_user.family_groups.include?(@family_group)
      redirect_to family_groups_path, alert: 'アクセス権限がありません。'
    end
  end
end
