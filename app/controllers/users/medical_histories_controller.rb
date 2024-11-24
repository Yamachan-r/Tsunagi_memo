class Users::MedicalHistoriesController < ApplicationController
  before_action :set_group
  before_action :set_user, only: [:index, :show]
  before_action :set_medical_history, only: [:show]

  def index
    @medical_histories = @user.medical_histories
  end

  def show
  end

  private

  def set_group
    @from_family_group = params[:from_family_group]
    @group = current_user.family_groups.find_by(id: @from_family_group)

    unless @group
      redirect_to family_groups_path, alert: "不正なアクセスです。"
    end
  end

  def set_user
    @user = @group.users.find_by(id: params[:user_id])

    unless @user
      redirect_to family_group_path(@group), alert: "指定されたユーザーが見つかりません。"
    end
  end

  def set_medical_history
    @medical_history = @user.medical_histories.find_by(id: params[:id])

    unless @medical_history
      redirect_to user_medical_histories_path(user_id: @user.id, from_family_group: @from_family_group), alert: "指定された病歴が見つかりません。"
    end
  end
end
