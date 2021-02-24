require 'rails_helper'

RSpec.describe '開発者管理機能', type: :system do
  let(:developer) { create(:developer) }
  let(:new_user) { create(:new_user) }
  let(:new_pharmacy) { create(:new_pharmacy) }
  let(:medicine) { create(:medicine, user_id: developer.id) }
  
  describe '開発者アカウント作成機能' do
    context 'アカウント登録ボタン' do
      it 'ユーザーのアカウント登録ボタンから開発者アカウントは作成できない' do
        expect(User.all.count).to eq 0
        visit new_user_registration_path
        fill_in 'user[name]', with: 'お試し登録'
        fill_in 'user[email]', with: 'otameshi@gmail.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'アカウント登録'
        expect(User.all.count).to eq 1
        expect(User.first.role).not_to eq 'developer'
      end
    end
  end

  describe '開発者ログイン機能' do
    before { developer }
    context 'ログインボタン' do
      it 'ユーザーでログインボタンから開発者はログインできる' do
        visit new_user_session_path
        fill_in 'user[name]', with: '開発者'
        fill_in 'user[email]', with: 'developer@gmail.com'
        fill_in 'user[password]', with: 'password'
        click_on 'ログイン'
        expect(developer.role).to eq 'developer'
      end
    end

    context '開発者がログインした場合' do
      before {
        visit new_user_session_path
        fill_in 'user[name]', with: '開発者'
        fill_in 'user[email]', with: 'developer@gmail.com'
        fill_in 'user[password]', with: 'password'
        click_on 'ログイン'
      }
      it '医薬品一覧ページへ遷移できる' do
        click_on '登録医薬品一覧へ移動'
        expect(current_path).to eq medicines_path
      end

      it '他のユーザーや薬局でログインできない' do
        expect(page).not_to have_content 'ユーザーでログイン' && '薬局でログイン'
      end

      it 'ログアウトできる' do
        click_on 'ログアウト'
        expect(current_path).to eq root_path
      end

      it '医薬品登録ができる' do
        click_on '登録医薬品一覧へ移動'
        click_on '医薬品登録へ移動'
        fill_in 'medicine[name]', with: 'sample_medicine錠'
        fill_in 'medicine[standard]', with: '1.5'
        find('#medicine_unit').set('mg')
        click_on '登録する'
        expect(current_path).to eq medicines_path
        expect(page).to have_content '医薬品を登録しました'
      end
      
      context '医薬品登録後' do
        before { 
          medicine
          click_on '登録医薬品一覧へ移動'
          click_on 'sample_medicine 1.5mg'
        }
        it '登録した医薬品の参照ができる' do
          expect(current_path).to eq medicine_path(medicine)
        end

        it '登録した医薬品の採用状態を許可に変更することはできない' do
          expect(page).not_to have_content 'この医薬品の採用を許可する'
        end

        it '医薬品の登録を削除することはできない' do
          expect(page).not_to have_content 'この医薬品の登録を削除する'
        end
      end
    end

    context '一般ユーザーでログインした場合' do
      before { user_login(new_user) }
      it '登録医薬品一覧ボタンがない' do
        expect(page).not_to have_content '登録医薬品一覧へ移動'
      end

      it '登録医薬品一覧ページに遷移できない' do
        visit medicines_path
        expect(current_path).not_to eq medicines_path
        expect(page).to have_content "特別な権限が必要です"
      end

      it '医薬品登録ページに遷移できない' do
        visit new_medicine_path
        expect(current_path).not_to eq medicines_path
        expect(page).to have_content "特別な権限が必要です"
      end

      it '医薬品詳細ページに遷移できない' do
        visit medicine_path(medicine)
        expect(current_path).not_to eq medicines_path
        expect(page).to have_content "特別な権限が必要です"
      end
    end

    context '薬局でログインした場合' do
      before { pharmacy_login(new_pharmacy) }
      it '登録医薬品一覧ボタンがない' do
        expect(page).not_to have_content '登録医薬品一覧へ移動'
      end

      it '登録医薬品一覧ページに遷移できない' do
        visit medicines_path
        expect(current_path).not_to eq medicines_path
        expect(page).to have_content "特別な権限が必要です"
      end

      it '医薬品登録ページに遷移できない' do
        visit new_medicine_path
        expect(current_path).not_to eq medicines_path
        expect(page).to have_content "特別な権限が必要です"
      end

      it '医薬品詳細ページに遷移できない' do
        visit medicine_path(medicine)
        expect(current_path).not_to eq medicines_path
        expect(page).to have_content "特別な権限が必要です"
      end
    end
  end
end
