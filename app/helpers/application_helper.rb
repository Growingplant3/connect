module ApplicationHelper
  def sign_in_or_sign_out_button
    if user_signed_in?
      link_to "ログアウトする", destroy_user_session_path, method: :delete
    else
      link_to "ログインする", new_user_session_path
    end
  end

  def sign_up_button
    unless user_signed_in?
      link_to "アカウントを作成する", new_user_registration_path
    end
  end
end
