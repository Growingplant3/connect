class InformationDisclosuresController < ApplicationController
  include CommonFunctions
  before_action :enable_for_user

  def create
    current_user.information_disclosures.create(pharmacy_id: params[:pharmacy_id])
    flash[:notice] = I18n.t('message.information_disclosure_create', pharmacy_name: set_pharmacy_name(params[:pharmacy_id]))
    redirect_back(fallback_location: pharmacy_path(params[:pharmacy_id]))
  end

  def destroy
    current_user.information_disclosures.find_by_pharmacy_id(params[:pharmacy_id]).destroy
    flash[:notice] = I18n.t('message.information_disclosure_destroy', pharmacy_name: set_pharmacy_name(params[:pharmacy_id]))
    redirect_back(fallback_location: pharmacy_path(params[:pharmacy_id]))
  end
end
