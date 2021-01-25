class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "編集成功"
      redirect_to @user
    else
      flash.now[:alert] = "編集失敗"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:postcode, :address, :telephone_number, :birthday, :sex, :side_effect, :allergy, :sick, :operation, :note)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
