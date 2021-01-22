module ApplicationHelper
  def sign_in_or_sign_out_button
    if user_signed_in?
      link_to "ログウトする", destroy_user_session_path, method: :delete
    else
      link_to "ログンする", new_user_session_path
    end
  end

  def sign_up_or_resource_show_button
    if user_signed_in?
      link_to "ユーザ情報確認", user_path(current_user)
    else
      link_to "アカントを作成する", new_user_registration_path
    end
  end
end
