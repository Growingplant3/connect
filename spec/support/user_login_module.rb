module UserLoginModule
  def user_login(user)
    visit new_user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'new_user'
    click_button 'ログイン'
  end
end
