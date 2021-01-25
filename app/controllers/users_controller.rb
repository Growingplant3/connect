class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = I18n.t('devise.registrations.updated')
      redirect_to @user
    else
      flash.now[:alert] = I18n.t('flash.alert.user.failure.update')
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
