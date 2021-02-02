module ApplicationHelper
  def welcome_model
    if user_signed_in?
      current_user.name + I18n.t('activerecord.models.welcome')
    elsif pharmacy_signed_in?
      current_pharmacy.name + I18n.t('activerecord.models.welcome')
    end
  end

  def user_sign_in_or_sign_out_button
    if user_signed_in?
      link_to t('button.sign_out'), destroy_user_session_path, method: :delete
    else
      unless pharmacy_signed_in?
        link_to t('devise.sessions.new.user_sign_in'), new_user_session_path
      end
    end
  end

  def pharmacy_sign_in_or_sign_out_button
    if pharmacy_signed_in?
      link_to t('button.sign_out'), destroy_pharmacy_session_path, method: :delete
    else
      unless user_signed_in?
        link_to t('devise.sessions.new.pharmacy_sign_in'), new_pharmacy_session_path
      end
    end
  end

  def user_sign_up_or_show_button
    if user_signed_in?
      link_to t('button.user_show'), current_user
    else
      unless user_signed_in? || pharmacy_signed_in?
        link_to t('devise.registrations.new.user_sign_up'), new_user_registration_path
      end
    end
  end

  def pharmacy_sign_up_or_show_button
    if pharmacy_signed_in?
      link_to t('button.pharmacy_show'), current_user
    else
      unless user_signed_in? || pharmacy_signed_in?
        link_to t('devise.registrations.new.pharmacy_sign_up'), new_pharmacy_registration_path
      end
    end
  end
end
