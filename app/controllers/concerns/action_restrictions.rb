module ActionRestrictions
  extend ActiveSupport::Concern

  def only_users
    if pharmacy_signed_in?
      flash[:alert] = I18n.t('flash.alert.user.only_users')
      redirect_back(fallback_location: root_path)
    end
  end

  def only_pharmacies
    if user_signed_in?
      flash[:alert] = I18n.t('flash.alert.pharmacy.only_pharmacies')
      redirect_back(fallback_location: root_path)
    end
  end
end
