require 'rails_helper'

RSpec.describe '管理者管理機能', type: :system do
  let(:admin) { create(:admin) }
  let(:new_user) { create(:new_user) }
  let(:new_pharmacy) { create(:new_pharmacy) }
  let(:medicine) { create(:medicine, user_id: admin.id) }
  
  describe '管理者アカウント作成機能' do
    context 'アカウント登録ボタン' do
      it 'ユーザーのアカウント登録ボタンから管理者アカウントは作成できない' do
        expect(User.count).to eq 0
        visit new_user_registration_path
        fill_in 'user[name]', with: 'お試し登録'
        fill_in 'user[email]', with: 'otameshi@gmail.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'アカウント登録'
        expect(User.count).to eq 1
        expect(User.first.role).not_to eq 'admin'
      end
    end
  end

  describe '管理者ログイン機能' do
    before { admin }
    context 'ログインボタン' do
      it 'ユーザーでログインボタンから管理者はログインできる' do
        visit new_user_session_path
        fill_in 'user[name]', with: '管理者'
        fill_in 'user[email]', with: 'admin@gmail.com'
        fill_in 'user[password]', with: 'password'
        click_on 'ログイン'
        expect(admin.role).to eq 'master'
      end
    end

    context '管理者がログインした場合' do
      before {
        visit new_user_session_path
        fill_in 'user[name]', with: '管理者'
        fill_in 'user[email]', with: 'admin@gmail.com'
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
        fill_in 'medicine[name]', with: 'sample_medicine'
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

        it '登録した医薬品の採用状態を許可に変更することができる' do
          page.accept_confirm do
            click_on 'この医薬品の採用を許可する'
          end
          expect(current_path).to eq medicine_path(medicine)
          expect(page).to have_content '医薬品登録が完了しました' && '許可'
        end

        it '医薬品の登録を削除することができる' do
          page.accept_confirm do
            click_on 'この医薬品の登録を削除する'
          end
          expect(current_path).to eq medicines_path
          expect(page).to have_content 'sample_medicineの登録を削除しました'
        end
      end
    end
  end
end
