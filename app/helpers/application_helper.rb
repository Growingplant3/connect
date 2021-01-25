module ApplicationHelper
  def welcome_model
    if user_signed_in?
      current_user.name + I18n.t('activerecord.models.welcome')
    end
  end

  def sign_in_or_sign_out_button
    if user_signed_in?
      link_to t('button.sign_out'), destroy_user_session_path, method: :delete
    else
      link_to t('devise.sessions.new.sign_in'), new_user_session_path
    end
  end

  def sign_up_or_resource_show_button
    if user_signed_in?
      link_to t('button.user_show'), current_user
    else
      link_to t('devise.registrations.new.sign_up'), new_user_registration_path
    end
  end
end
