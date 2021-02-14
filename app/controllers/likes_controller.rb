class LikesController < ApplicationController
  include CommonFunctions
  before_action :enable_for_user

  def create
    current_user.likes.create(pharmacy_id: params[:pharmacy_id])
    flash[:notice] = I18n.t('message.like_create')
    redirect_back(fallback_location: pharmacy_path(params[:pharmacy_id]))
  end

  def destroy
    current_user.likes.find_by_pharmacy_id(params[:pharmacy_id]).destroy
    flash[:notice] = I18n.t('message.like_destroy')
    redirect_back(fallback_location: pharmacy_path(params[:pharmacy_id]))
  end
end
