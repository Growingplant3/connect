module PharmacyLoginModule
  def pharmacy_login(pharmacy)
    visit new_pharmacy_session_path
    fill_in 'pharmacy[name]', with: pharmacy.name
    fill_in 'pharmacy[email]', with: pharmacy.email
    fill_in 'pharmacy[password]', with: 'new_pharmacy'
    click_button 'ログイン'
  end
end
