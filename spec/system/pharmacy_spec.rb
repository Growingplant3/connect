require 'rails_helper'
RSpec.describe '薬局管理機能', type: :system do
  let(:new_pharmacy) { create(:new_pharmacy) }

  describe 'サインアップ機能' do
    before { visit new_pharmacy_registration_path }
    describe '成功' do
      context 'サインアップできる場合' do
        it '必要項目を満たせばサインアップできる' do
          fill_in 'pharmacy[name]', with: '新規登録薬局'
          fill_in 'pharmacy[email]', with: 'new_pharmacy@gmail.com'
          fill_in 'pharmacy[password]', with: 'new_pharmacy'
          fill_in 'pharmacy[password_confirmation]', with: 'new_pharmacy'
          click_button 'アカウント登録'
          expect(page).to have_content 'アカウント登録が完了しました。' && '続けて薬局情報を設定してください。' && '薬局情報を編集中'
        end
      end
    end

    describe '失敗' do
      after { expect(current_path).to eq pharmacy_registration_path }
      context 'サインアップできない場合' do
        it '薬局名が空だとサインアップできない' do
          fill_in 'pharmacy[email]', with: 'pharmacy_user@gmail.com'
          fill_in 'pharmacy[password]', with: 'pharmacy_user'
          fill_in 'pharmacy[password_confirmation]', with: 'pharmacy_user'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため 薬局 は保存されませんでした。' && '薬局名を入力してください'
        end

        it 'メールアドレスが空だとサインアップできない' do
          fill_in 'pharmacy[name]', with: '新規登録薬局'
          fill_in 'pharmacy[password]', with: 'new_pharmacy'
          fill_in 'pharmacy[password_confirmation]', with: 'new_pharmacy'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため 薬局 は保存されませんでした。' && 'Eメールを入力してください'
        end

        it 'パスワードが空だとサインアップできない' do
          fill_in 'pharmacy[name]', with: '新規登録薬局'
          fill_in 'pharmacy[email]', with: 'new_pharmacy@gmail.com'
          fill_in 'pharmacy[password_confirmation]', with: 'new_pharmacy'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため 薬局 は保存されませんでした。' && 'パスワードを入力してください' && 'パスワード（確認用）とパスワードの入力が一致しません'
        end

        it '確認用パスワードが空だとサインアップできない' do
          fill_in 'pharmacy[name]', with: '新規登録薬局'
          fill_in 'pharmacy[email]', with: 'new_pharmacy@gmail.com'
          fill_in 'pharmacy[password]', with: 'new_pharmacy'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため 薬局 は保存されませんでした。' && 'パスワードを入力してください' && 'パスワード（確認用）とパスワードの入力が一致しません'
        end

        it 'パスワードと確認用パスワードが一致していなければサインアップできない' do
          fill_in 'pharmacy[name]', with: '新規登録薬局'
          fill_in 'pharmacy[email]', with: 'new_pharmacy@gmail.com'
          fill_in 'pharmacy[password]', with: 'new_pharmacy'
          fill_in 'pharmacy[password_confirmation]', with: 'password'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため 薬局 は保存されませんでした。' && 'パスワード（確認用）とパスワードの入力が一致しません'
        end

        it 'すでに存在している薬局のメールアドレスと同じメールアドレスだとサインアップできない' do
          new_pharmacy
          fill_in 'pharmacy[name]', with: '遅れてきた薬局'
          fill_in 'pharmacy[email]', with: 'new_pharmacy@gmail.com'
          fill_in 'pharmacy[password]', with: 'password'
          fill_in 'pharmacy[password_confirmation]', with: 'password'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため 薬局 は保存されませんでした。' && 'Eメールはすでに存在します'
        end
      end
    end
  end

  describe 'ログイン機能' do
    before {
      visit new_pharmacy_session_path
      new_pharmacy
    }
    describe '成功' do
      context 'ログインできる場合' do
        it '必要項目を満たせばログインできる' do
          fill_in 'pharmacy[name]', with: new_pharmacy.name
          fill_in 'pharmacy[email]', with: new_pharmacy.email
          fill_in 'pharmacy[password]', with: 'new_pharmacy'
          click_button 'ログイン'
          expect(page).to have_content 'ログインしました。' && '薬局情報を確認中'
          expect(current_path).to eq pharmacy_path(new_pharmacy)
        end
      end
    end

    describe '失敗' do
      after {
        click_button 'ログイン'
        expect(page).to have_content '薬局名、Eメールまたはパスワードが違います。'
        expect(current_path).to eq new_pharmacy_session_path
      }
      context 'ログインできない場合' do
        it '薬局名が空だとログインできない' do
          fill_in 'pharmacy[email]', with: new_pharmacy.email
          fill_in 'pharmacy[password]', with: 'new_pharmacy'
        end
        
        it 'メールアドレスが空だとログインできない' do
          fill_in 'pharmacy[name]', with: new_pharmacy.name
          fill_in 'pharmacy[password]', with: 'new_pharmacy'
        end

        it 'パスワードが空だとログインできない' do
          fill_in 'pharmacy[name]', with: new_pharmacy.name
          fill_in 'pharmacy[email]', with: new_pharmacy.email
        end

        it '薬局名が正しくないとログインできない' do
          fill_in 'pharmacy[name]', with: 'another_pharmacy'
          fill_in 'pharmacy[email]', with: new_pharmacy.email
          fill_in 'pharmacy[password]', with: 'new_pharmacy'
        end

        it 'メールアドレスが正しくないとログインできない' do
          fill_in 'pharmacy[name]', with: new_pharmacy.name
          fill_in 'pharmacy[email]', with: 'another_pharmacy@gmail.com'
          fill_in 'pharmacy[password]', with: 'new_pharmacy'
        end

        it 'パスワードが正しくないとログインできない' do
          fill_in 'pharmacy[name]', with: new_pharmacy.name
          fill_in 'pharmacy[email]', with: new_pharmacy.email
          fill_in 'pharmacy[password]', with: 'another_pharmacy'
        end
      end
    end
  end

  describe 'ログイン後' do
    before { pharmacy_login(new_pharmacy) }
    describe 'アカウントの削除' do
      context '成功' do
        it 'アカウント削除ボタンからアカウントが削除できる' do
          page.accept_confirm do
            click_on 'アカウントを削除する'
          end
          expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
          expect(current_path).to eq root_path
        end
      end
    end

    describe 'アカウントの編集' do
      before { visit edit_pharmacy_path(new_pharmacy) }
      after { expect(current_path).to eq pharmacy_path(new_pharmacy) }
      context '成功' do
        it '入力欄に適切な値を記述し更新ボタンを押すとアカウントが編集できる' do
          fill_in 'pharmacy[postcode]', with: '1234567'
          fill_in 'pharmacy[address]', with: '神奈川'
          fill_in 'pharmacy[normal_telephone_number]', with: '0312348765'
          fill_in 'pharmacy[emergency_telephone_number]', with: '09087654321'
          fill_in 'pharmacy[note]', with: '年末年始の開局情報についてお知らせです♪12月30日より1月3日まではお休みを頂きます★'
          click_on '更新'
          expect(page).to have_content 'アカウント情報を変更しました。' && '薬局情報を確認中'
          expect(current_path).to eq pharmacy_path(new_pharmacy)
        end

        it '郵便番号に全角数字を入力すると半角数字に変換されて保存される' do
          fill_in 'pharmacy[postcode]', with: '１２３４５６７'
          click_on '更新'
          expect(page).to have_content '1234567'
        end

        it '通常電話番号に全角数字を入力すると半角数字に変換されて保存される' do
          fill_in 'pharmacy[normal_telephone_number]', with: '０３１２３４８７６５'
          click_on '更新'
          expect(page).to have_content '0312348765'
        end

        it '緊急時電話番号に全角数字を入力すると半角数字に変換されて保存される' do
          fill_in 'pharmacy[emergency_telephone_number]', with: '０３１２３４５６７８'
          click_on '更新'
          expect(page).to have_content '0312345678'
        end
      end

      context '失敗' do
        it '郵便番号に数字以外を入力すると更新できない' do
          fill_in 'pharmacy[postcode]', with: 'abcdefg'
          click_on '更新'
          expect(page).to have_content 'アカウントの編集ができませんでした。' && '郵便番号は不正な値です'
        end

        it '通常電話番号に数字以外を入力すると更新できない' do
          fill_in 'pharmacy[normal_telephone_number]', with: 'abcdefghij'
          click_on '更新'
          expect(page).to have_content 'アカウントの編集ができませんでした。' && '通常電話番号は不正な値です'
        end

        it '緊急時電話番号に数字以外を入力すると更新できない' do
          fill_in 'pharmacy[emergency_telephone_number]', with: 'abcdefghij'
          click_on '更新'
          expect(page).to have_content 'アカウントの編集ができませんでした。' && '緊急時電話番号は不正な値です'
        end
      end
    end

    describe 'パスワードの変更' do
      context '成功' do
        it 'パスワード更新ボタンからパスワードが再設定できる' do
          visit edit_pharmacy_registration_path
          fill_in 'pharmacy[password]', with: 'new_password'
          fill_in 'pharmacy[password_confirmation]', with: 'new_password'
          fill_in 'pharmacy[current_password]', with: 'new_pharmacy'
          click_on '更新'
          expect(page).to have_content 'アカウント情報を変更しました。'
          expect(current_path).to eq root_path
        end
      end
    end
  end
end
