class UsersController < ApplicationController
  before_action :set_user, except: [:index]
  before_action :only_myself, except: %i[index show]
  before_action :all_pharmacies, only: [:index]
  before_action :myself_of_pharmacies, only: [:show]

  def index
    @gender_choices = User.set_gender
    @q = User.standard_exclusion(limited_user_ids).selection(params[:q]).ransack(params[:q])
    @Users = @q.result(distinct: true)
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

  def only_myself
    if @user != current_user
      flash[:alert] = I18n.t('flash.alert.user.only_myself')
      redirect_to root_path
    end
  end

  def all_pharmacies
    unless pharmacy_signed_in?
      flash[:alert] = I18n.t('flash.alert.pharmacy.all_pharmacies')
      redirect_to root_path
    end
  end

  def myself_of_pharmacies
    unless @user == current_user || pharmacy_signed_in?
      flash[:alert] = I18n.t('flash.alert.user.myself_or_pharmacies')
      redirect_to root_path
    end
  end

  def limited_user_ids
    Pharmacy.have_search_permission(session[:pharmacy_id])
  end
end
