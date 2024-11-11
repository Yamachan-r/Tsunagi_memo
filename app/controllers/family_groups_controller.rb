class FamilyGroupsController < ApplicationController
  def index
    @family_groups = current_user.family_groups
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

  private

  def family_group_params
    params.require(:family_group).permit(:name)
  end
end
