class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show; #同じグループに属している人が見ることができるように
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

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :gender, :birth_date, :blood_type)
  end
end