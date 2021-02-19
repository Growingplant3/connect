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
      link_to t('button.sign_out'), destroy_user_session_path, method: :delete, class: "btn btn-warning"
    else
      unless pharmacy_signed_in?
        link_to t('devise.sessions.new.user_sign_in'), new_user_session_path, class: "btn btn-warning"
      end
    end
  end

  def pharmacy_sign_in_or_sign_out_button
    if pharmacy_signed_in?
      link_to t('button.sign_out'), destroy_pharmacy_session_path, method: :delete, class: "btn btn-warning"
    else
      unless user_signed_in?
        link_to t('devise.sessions.new.pharmacy_sign_in'), new_pharmacy_session_path, class: "btn btn-warning"
      end
    end
  end

  def user_sign_up_or_show_button
    if user_signed_in?
      link_to t('button.user_show'), current_user, class: "btn btn-info"
    else
      unless user_signed_in? || pharmacy_signed_in?
        link_to t('devise.registrations.new.user_sign_up'), new_user_registration_path, class: "btn btn-info"
      end
    end
  end

  def pharmacy_sign_up_or_show_button
    if pharmacy_signed_in?
      link_to t('button.pharmacy_show'), current_user, class: "btn btn-info"
    else
      unless user_signed_in? || pharmacy_signed_in?
        link_to t('devise.registrations.new.pharmacy_sign_up'), new_pharmacy_registration_path, class: "btn btn-info"
      end
    end
  end

  def user_search_button
    if pharmacy_signed_in?
      link_to t('activerecord.title.user.search'), users_path(session[:pharmacy_id] = current_pharmacy.id), class: "btn btn-primary"
    end      
  end

  def developer_button
    return unless user_signed_in?
    if current_user.role == "developer" || current_user.role == "master"
      link_to t('button.medicine_index'), medicines_path, class: "btn btn-danger"
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

  def sample_user_first_login
    unless user_signed_in? || pharmacy_signed_in?
      link_to t('button.sample_user_first'), homes_sample_user_first_sign_in_path, method: :post, class: "btn btn-success"
    end
  end

  def sample_user_second_login
    unless user_signed_in? || pharmacy_signed_in?
      link_to t('button.sample_user_second'), homes_sample_user_second_sign_in_path, method: :post, class: "btn btn-success"
    end
  end

  def sample_pharmacy_login
    unless user_signed_in? || pharmacy_signed_in?
      link_to t('button.sample_pharmacy'), homes_sample_pharmacy_sign_in_path, method: :post, class: "btn btn-success"
    end
  end

  def developer_login
    unless user_signed_in? || pharmacy_signed_in?
      link_to t('button.developer'), homes_developer_sign_in_path, method: :post, class: "btn btn-success"
    end
  end

  def admin_login
    unless user_signed_in? || pharmacy_signed_in?
      link_to t('button.admin'), homes_admin_sign_in_path, method: :post, class: "btn btn-success"
    end
  end

  def create_or_update_root
    case action_name
    when "new","create"
      user_medicine_notebook_record_prescription_details_path(params[:user_id], params[:medicine_notebook_record_id]) if controller_name == "prescription_details"
      user_medicine_notebook_records_path(params[:user_id]) if controller_name == "medicine_notebook_records"
      medicines_path if controller_name == "medicines"
      take_method_details_path if controller_name == "take_method_details"
    when "edit","update"
      user_medicine_notebook_record_prescription_detail_path(params[:user_id], params[:medicine_notebook_record_id], params[:id]) if controller_name == "prescription_details"
      user_medicine_notebook_record_path(params[:user_id], params[:id]) if controller_name == "medicine_notebook_records"
      medicine_path if controller_name == "medicines"
      take_method_detail_path if controller_name == "take_method_details"
    end
  end

  def action_name_button
    case action_name
    when "new" || "create"
      I18n.t('helpers.submit.create')
    when "edit" || "update"
      I18n.t('helpers.submit.update')
    end
  end

  def user_button_in_users_show(user)
    if user == current_user
      render partial: "shared/user_button_in_users_show", locals: { user: user }
    end
  end

  def pharmacy_or_current_user_button_in_users_show(user)
    if pharmacy_signed_in?
      render partial: "shared/pharmacy_button_in_users_show", locals: { user: user }
    elsif user == current_user
      render partial: "shared/current_user_button_in_users_show", locals: { user: user }
    end
  end

  def nothing_medicine_notebook_record(medicine_notebook_record)
    if medicine_notebook_record.blank?
      I18n.t('activerecord.attributes.medicine_notebook_record.index.nothing')
    end
  end

  def pharmacy_button_in_medicine_notebook_records_show(user,medicine_notebook_record)
    if pharmacy_signed_in?
      render partial: "shared/pharmacy_button_in_medicine_notebook_records_show", locals: { user: user, medicine_notebook_record: medicine_notebook_record }
    end
  end

  def pharmacy_button_in_medicine_notebook_records_index(user)
    if pharmacy_signed_in?
      render partial: "shared/pharmacy_button_in_medicine_notebook_records_index", locals: { user: user }
    end
  end
  
  def pharmacy_button_in_medicine_show(current_user,medicine)
    if current_user.role == "master"
      render partial: "button", locals: { medicine: medicine }
    end
  end

  def delete_button_in_prescription_detail_edit
    if action_name == "edit"
      link_to t('button.prescription_detail_destroy'), user_medicine_notebook_record_prescription_detail_path(@user, @medicine_notebook_record, @prescription_detail), method: :delete, data: { confirm: t('message.prescription_detail.destroy_confirm') }
    end
  end

  def only_master_view_in_medicines_index(role,name)
    if role == "master"
      I18n.t('activerecord.title.medicine.only_master', name: name)
    end
  end

  def medicine_link_button(user, medicine_notebook_record, detail, medicine)
    if pharmacy_signed_in?
      link_to "#{medicine.name}#{medicine.standard}#{medicine.unit}", edit_user_medicine_notebook_record_prescription_detail_path(user, medicine_notebook_record, detail)
    elsif user_signed_in?
      "#{medicine.name}#{medicine.standard}#{medicine.unit}"
    end
  end
end
