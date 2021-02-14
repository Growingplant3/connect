module CommonFunctions
  extend ActiveSupport::Concern

  def set_pharmacy_name(pharmacy_id)
    Pharmacy.find(pharmacy_id).name
  end

  private

  def enable_for_user
    unless user_signed_in?
      redirect_to root_path
    end
  end
end
