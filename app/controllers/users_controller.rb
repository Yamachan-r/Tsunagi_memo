class UsersController < ApplicationController
  before_action :set_current_user, only: [ :edit, :update ]
  before_action :validate_user_group_membership, only: [ :show ]

  def show
    @user = User.find_by(id: params[:id])
    @from_family_group = params[:from_family_group]
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "更新しました"
    else
      flash.now["danger"] = t("defaults.flash_message.not_updated", item: User.model_name.human)
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

  def validate_user_group_membership
    group_id = params[:from_family_group]
    user_id = params[:id]
    validate_group_membership(group_id, user_id)
  end
end
