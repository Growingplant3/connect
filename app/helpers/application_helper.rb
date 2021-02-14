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

  def user_search_button
    if pharmacy_signed_in?
      link_to t('activerecord.title.user.search'), users_path(session[:pharmacy_id] = current_pharmacy.id)
    end      
  end

  def from_start_to_finish(activity)
    return if activity.business == "false" || activity.opening_time.blank? || activity.closing_time.blank?
    open = activity.opening_time.strftime("%R")
    close = activity.closing_time.strftime("%R")
    "#{open}〜#{close}"
  end

  def button_view(resource)
    if resource == current_pharmacy
      render partial: "button", locals: { pharmacy: resource }
    end
  end

  def likes_button_view(resource)
    return unless user_signed_in?
    if current_user.likes.find_by_pharmacy_id(resource)
      link_to I18n.t('button.like_destroy'), like_path(pharmacy_id: resource), method: :delete
    else
      link_to I18n.t('button.like_create'), likes_path(pharmacy_id: resource), method: :post
    end
  end

  def infoformation_disclosures_button_view(resource)
    return unless user_signed_in?
    if current_user.information_disclosures.find_by_pharmacy_id(resource)
      link_to I18n.t('button.information_disclosure_destroy'), information_disclosure_path(pharmacy_id: resource), method: :delete
    else
      link_to I18n.t('button.information_disclosure_create'), information_disclosures_path(pharmacy_id: resource), method: :post, data: { confirm: I18n.t('message.check_again') }
    end
  end

  def likes_expression(length)
    if length >= 100
      I18n.t('message.great_number_of_likes', count: length)
    elsif length > 0
      I18n.t('message.number_of_likes', count: length)
    end
  end
end
