require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  let(:new_user) { FactoryBot.create(:new_user) }

  describe 'サインアップ機能' do
    before { visit new_user_registration_path }
    describe '成功' do
      context 'サインアップできる場合' do
        it '必要項目を満たせばサインアップできる' do
          fill_in 'user[name]', with: '新規登録ユーザー'
          fill_in 'user[email]', with: 'new_user@gmail.com'
          fill_in 'user[password]', with: 'new_user'
          fill_in 'user[password_confirmation]', with: 'new_user'
          click_button 'アカウント登録'
          expect(page).to have_content 'アカウント登録が完了しました。' && '続けてユーザー情報を設定してください。' && 'ユーザー情報を編集中'
        end
      end
    end

    describe '失敗' do
      after { expect(current_path).to eq user_registration_path }
      context 'サインアップできない場合' do
        it 'ユーザー名が空だとサインアップできない' do
          fill_in 'user[email]', with: 'new_user@gmail.com'
          fill_in 'user[password]', with: 'new_user'
          fill_in 'user[password_confirmation]', with: 'new_user'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。' && 'ユーザー名を入力してください'
        end

        it 'メールアドレスが空だとサインアップできない' do
          fill_in 'user[name]', with: '新規登録ユーザー'
          fill_in 'user[password]', with: 'new_user'
          fill_in 'user[password_confirmation]', with: 'new_user'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。' && 'Eメールを入力してください'
        end

        it 'パスワードが空だとサインアップできない' do
          fill_in 'user[name]', with: '新規登録ユーザー'
          fill_in 'user[email]', with: 'new_user@gmail.com'
          fill_in 'user[password_confirmation]', with: 'new_user'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。' && 'パスワードを入力してください' && 'パスワード（確認用）とパスワードの入力が一致しません'
        end

        it '確認用パスワードが空だとサインアップできない' do
          fill_in 'user[name]', with: '新規登録ユーザー'
          fill_in 'user[email]', with: 'new_user@gmail.com'
          fill_in 'user[password]', with: 'new_user'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。' && 'パスワードを入力してください' && 'パスワード（確認用）とパスワードの入力が一致しません'
        end

        it 'パスワードが空だとサインアップできない' do
          fill_in 'user[name]', with: '新規登録ユーザー'
          fill_in 'user[email]', with: 'new_user@gmail.com'
          fill_in 'user[password_confirmation]', with: 'new_user'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。' && 'パスワードを入力してください' && 'パスワード（確認用）とパスワードの入力が一致しません'
        end

        it 'パスワードと確認用パスワードが一致していなければサインアップできない' do
          fill_in 'user[name]', with: '新規登録ユーザー'
          fill_in 'user[email]', with: 'new_user@gmail.com'
          fill_in 'user[password]', with: 'new_user'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。' && 'パスワード（確認用）とパスワードの入力が一致しません'
        end
      end
    end
  end

  describe 'ログイン機能' do
    before {
      visit new_user_session_path
      new_user
    }
    describe '成功' do
      context 'ログインできる場合' do
        it '必要項目を満たせばログインできる' do
          fill_in 'user[name]', with: new_user.name
          fill_in 'user[email]', with: new_user.email
          fill_in 'user[password]', with: 'new_user'
          click_button 'ログイン'
          expect(page).to have_content 'ログインしました。' && 'ユーザー情報を確認中'
          expect(current_path).to eq user_path(new_user.id)
        end
      end
    end

    describe '失敗' do
      after {
        click_button 'ログイン'
        expect(page).to have_content 'ユーザー名、Eメールまたはパスワードが違います。'
        expect(current_path).to eq new_user_session_path
      }
      context 'ログインできない場合' do
        it 'ユーザー名が空だとログインできない' do
          fill_in 'user[email]', with: new_user.email
          fill_in 'user[password]', with: 'new_user'
        end
        
        it 'メールアドレスが空だとログインできない' do
          fill_in 'user[name]', with: new_user.name
          fill_in 'user[password]', with: 'new_user'
        end

        it 'パスワードが空だとログインできない' do
          fill_in 'user[name]', with: new_user.name
          fill_in 'user[email]', with: new_user.email
        end

        it 'ユーザー名が正しくないとログインできない' do
          fill_in 'user[name]', with: 'another_user'
          fill_in 'user[email]', with: new_user.email
          fill_in 'user[password]', with: 'new_user'
        end

        it 'メールアドレスが正しくないとログインできない' do
          fill_in 'user[name]', with: new_user.name
          fill_in 'user[email]', with: 'another_user@gmail.com'
          fill_in 'user[password]', with: 'new_user'
        end

        it 'パスワードが正しくないとログインできない' do
          fill_in 'user[name]', with: new_user.name
          fill_in 'user[email]', with: new_user.email
          fill_in 'user[password]', with: 'another_user'
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login(new_user) }
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
      before { visit edit_user_path(new_user) }
      after { expect(current_path).to eq user_path(new_user) }
      context '成功' do
        it '入力欄に適切な値を記述し更新ボタンを押すとアカウントが編集できる' do
          fill_in 'user[postcode]', with: '1234567'
          fill_in 'user[address]', with: '神奈川'
          fill_in 'user[telephone_number]', with: '09012345678'
          fill_in 'user[birthday]', with: '001999-12-31'
          find("option[value='female']").select_option
          fill_in 'user[side_effect]', with: '特になし'
          fill_in 'user[allergy]', with: '特になし'
          fill_in 'user[sick]', with: '特になし'
          fill_in 'user[operation]', with: '特になし'
          fill_in 'user[note]', with: '特になし'
          click_on '更新'
          expect(page).to have_content 'アカウント情報を変更しました。' && 'ユーザー情報を確認中'
          expect(current_path).to eq user_path(new_user)
        end
      end

      context '失敗' do
        # it '以下の四項目が未入力だとアカウント情報が更新できない'
        #   click_on '更新'
        #   expect(page).to have_content '郵便番号は不正な値です' && '郵便番号は7文字で入力してください' && '電話番号は不正な値です' && '電話番号は10文字以上で入力してください'
        # end

        it '郵便番号に数値以外を入力すると更新できない' do
          fill_in 'user[postcode]', with: 'abcdefg'
          click_on '更新'
          expect(page).to have_content 'アカウントの編集ができませんでした。' && '郵便番号は不正な値です'
        end

        it '電話番号に数字以外を入力すると更新できない' do
          fill_in 'user[telephone_number]', with: 'abcdefghij'
          click_on '更新'
          expect(page).to have_content 'アカウントの編集ができませんでした。' && '電話番号は不正な値です'
        end
      end
    end

    describe 'aaa' do
      it 'パスワード更新ボタンからパスワードが再設定できる' do
        visit edit_user_registration_path
        fill_in 'user[password]', with: 'new_password'
        fill_in 'user[password_confirmation]', with: 'new_password'
        fill_in 'user[current_password]', with: 'new_user'
        click_on '更新'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(current_path).to eq root_path
      end
    end
  end
end
