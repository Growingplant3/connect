require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  let(:new_user) { FactoryBot.create(:new_user) }

  describe 'サインアップ機能' do
    it '必要項目を満たせばサインアップできる' do
      visit new_user_registration_path
      fill_in 'user[name]', with: '新規登録ユーザー'
      fill_in 'user[email]', with: 'new_user@gmail.com'
      fill_in 'user[password]', with: 'new_user'
      fill_in 'user[password_confirmation]', with: 'new_user'
      click_button 'アカウント登録'
      expect(page).to have_content 'アカウント登録が完了しました。' && '続けてユーザー情報を設定してください。'
      expect(page).to have_content 'ユーザー情報を編集中'
    end
  end
end
