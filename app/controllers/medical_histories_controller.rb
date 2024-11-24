class MedicalHistoriesController < ApplicationController
  before_action :set_medical_history, only: [ :show, :edit, :update, :destroy ]

  def index
    @medical_histories = current_user.medical_histories.order(age_at_diagnosis: :asc)
  end

  def show; end

  def new
    @medical_history = MedicalHistory.new
  end

  def create
    @medical_history = current_user.medical_histories.build(medical_history_params)
    if @medical_history.save
      redirect_to medical_histories_path, notice: "病歴を登録しました。"
    else
      flash[:alert] = "新規登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @medical_history.update(medical_history_params)
      redirect_to medical_histories_path, notice: "病歴を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @medical_history.destroy!
    redirect_to medical_histories_path, success: "選択した病歴を削除しました"
  end

  private

  def medical_history_params
    params.require(:medical_history).permit(:disease, :age_at_diagnosis, :treatment_status, :disease_notes)
  end

  def set_medical_history
    @medical_history = current_user.medical_histories.find(params[:id])
  end
end
