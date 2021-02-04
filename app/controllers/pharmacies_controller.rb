class PharmaciesController < ApplicationController
  before_action :set_pharmacy, except: [:index]

  def index
    @q = Pharmacy.ransack(params[:q])
    @pharmacies = @q.result(distinct: true)
  end

  def show
  end

  def edit
    if @pharmacy.activities.blank?
      7.times do |week_number|
        @pharmacy.activities.build(day_of_the_week: week_number).save
      end
    end
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
    params.require(:pharmacy).permit(:postcode, :address, :normal_telephone_number, :emergency_telephone_number, :note,
      activities_attributes: [:id, :business, :opening_time, :closing_time]
    )
  end

  def set_pharmacy
    @pharmacy = Pharmacy.find(params[:id])
  end
end
