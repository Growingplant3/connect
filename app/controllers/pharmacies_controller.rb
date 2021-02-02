class PharmaciesController < ApplicationController
  before_action :set_pharmacy

  def show
  end

  def edit
  end

  def update
    if @pharmacy.update(pharmacies_params)
      flash[:notice] = I18n.t('devise.registrations.updated')
      redirect_to @pharmacy
    else
      flash.now[:alert] = I18n.t('flash.alert.user.failure.update')
      render :edit
    end
  end
  
  def destroy
    @pharmacy.destroy
    flash[:notice] = I18n.t('devise.registrations.destroyed')
    redirect_to root_path
  end

  private

  def pharmacies_params
    params.require(:pharmacy).permit(:postcode, :address, :normal_telephone_number, :emergency_telephone_number, :note)
  end

  def set_pharmacy
    @pharmacy = Pharmacy.find(params[:id])
  end
end
