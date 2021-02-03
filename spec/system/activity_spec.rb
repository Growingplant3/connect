require 'rails_helper'
RSpec.describe '開局状況管理機能', type: :system do
  let(:new_pharmacy) { create(:new_pharmacy) }
  
  describe '自動作成機能' do
    context '薬局登録後に薬局編集画面へリダイレクトした直後' do
      it '7つのレコードが自動で作成される' do
        visit new_pharmacy_registration_path
        before = Activity.count
        fill_in 'pharmacy[name]', with: '新規登録薬局'
        fill_in 'pharmacy[email]', with: 'new_pharmacy@gmail.com'
        fill_in 'pharmacy[password]', with: 'new_pharmacy'
        fill_in 'pharmacy[password_confirmation]', with: 'new_pharmacy'
        click_button 'アカウント登録'
        after = Activity.count
        expect(after - before).to eq 7
      end
    end
  end

  describe '編集機能' do
    before { 
      pharmacy_login(new_pharmacy)
      visit edit_pharmacy_path(new_pharmacy)
    }
    context '薬局編集画面で開局状況の編集ができる' do
      it '開局を選択かつ、開局時間と閉局時間に適切な値を入力するとブラウザ上に出力できる' do
        find("#pharmacy_activities_attributes_0_business").find("option[value='true']").select_option
        find("#pharmacy_activities_attributes_0_opening_time").set('09:30')
        find("#pharmacy_activities_attributes_0_closing_time").set('18:30')
        click_button '更新'
        expect(page).to have_content '開局' && '09:30〜18:30'
      end

      it 'お休みだと時刻を設定してもブラウザ上に出力されない' do
        find("#pharmacy_activities_attributes_0_opening_time").set('09:30')
        find("#pharmacy_activities_attributes_0_closing_time").set('18:30')
        click_button '更新'
        expect(page).not_to have_content '09:30' && '18:30'
      end
    end
  end
end
