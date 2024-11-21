class UsersController < ApplicationController
  before_action :set_current_user, only: %i[edit update]
  before_action :validate_group_membership, only: [:show]

  def show
    @user = User.find_by(id: params[:id])
    @from_family_group = params[:from_family_group]
  end
  
  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "更新しました"
    else
      flash.now['danger'] = t('defaults.flash_message.not_updated', item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_current_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :gender, :birth_date, :blood_type)
  end

  # グループとユーザーの関連性を検証
  def validate_group_membership
    group_id = params[:from_family_group]
    user_id = params[:id]

    # グループが存在し、ログインユーザーが所属しているかを確認
    family_group = current_user.family_groups.find_by(id: group_id)
    unless family_group
      redirect_to family_groups_path, alert: '不正なアクセスです。'
      return
    end

    # グループに属しているユーザーか確認
    user = family_group.users.find_by(id: user_id)
    unless user
      redirect_to family_group_path(group_id), alert: 'このユーザーの詳細を見る権限がありません。'
    end
  end
end