class UsersController < ApplicationController
  before_action :set_user, except: [:index]
  before_action :only_for_myself, except: [:index]

  def index
    @gender_choices = {}
    User.sexes_i18n.values.each_with_index do |value, index|
      @gender_choices[value] = index
    end
    @q = User.ransack(params[:q])
    @Users = @q.result(distinct: true).selection(params[:q])
  end

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
  
  def destroy
    @user.destroy
    flash[:notice] = I18n.t('devise.registrations.destroyed')
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:postcode, :address, :telephone_number, :birthday, :sex, :side_effect, :allergy, :sick, :operation, :note)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def only_for_myself
    if @user != current_user
      flash[:danger] = "他人のデータは触らせねぇ"
      redirect_to curent_user
    end
  end
end
