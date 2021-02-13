require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  let(:new_user) { create(:new_user) }
  let(:user) { create(:user) }
  let(:new_pharmacy) { create(:new_pharmacy) }

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

        it 'パスワードと確認用パスワードが一致していなければサインアップできない' do
          fill_in 'user[name]', with: '新規登録ユーザー'
          fill_in 'user[email]', with: 'new_user@gmail.com'
          fill_in 'user[password]', with: 'new_user'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。' && 'パスワード（確認用）とパスワードの入力が一致しません'
        end

        it 'すでに存在しているユーザーのメールアドレスと同じメールアドレスだとサインアップできない' do
          new_user
          fill_in 'user[name]', with: '遅れてきたユーザー'
          fill_in 'user[email]', with: 'new_user@gmail.com'
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button 'アカウント登録'
          expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。' && 'Eメールはすでに存在します'
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
    before { user_login(new_user) }
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

        it '郵便番号に全角数字を入力すると半角数字に変換されて保存される' do
          fill_in 'user[postcode]', with: '１２３４５６７'
          click_on '更新'
          expect(page).to have_content '1234567'
        end

        it '電話番号に全角数字を入力すると半角数字に変換されて保存される' do
          fill_in 'user[telephone_number]', with: '０３１２３４５６７８'
          click_on '更新'
          expect(page).to have_content '0312345678'
        end
      end

      context '失敗' do
        it '郵便番号に数字以外を入力すると更新できない' do
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

    describe 'パスワードの変更' do
      context '成功' do
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

    describe 'いいね機能' do
      context 'いいねをつける' do
        before {
          expect(Like.all.count).to eq 0
          visit pharmacy_path(new_pharmacy)
          click_on 'この薬局にいいねする'
        }
        it 'いいねをつけていない薬局には、いいねをつけられる' do
          expect(page).to have_content 'この薬局にいいねをつけました'
          expect(Like.first.user).to eq new_user
          expect(Like.first.pharmacy).to eq new_pharmacy
        end

        it 'いいねをつけている薬局には、さらにいいねをつける事はできない' do
          expect(page).not_to have_content 'この薬局にいいねする'
        end
      end

      context 'いいねを解除する' do
        before { visit pharmacy_path(new_pharmacy) }
        it 'いいねをつけている薬局の、いいねを解除できる' do
          click_on 'この薬局にいいねする'
          click_on 'この薬局のいいねを解除する'
          expect(Like.all.count).to eq 0
          expect(page).to have_content 'この薬局のいいねを解除しました'
        end

        it 'いいねをつけていない薬局の、いいねを解除する事はできない' do
          expect(page).not_to have_content 'この薬局のいいねを解除する'
        end
      end
    end
  end

  describe 'ユーザー機能の制限' do
    before {
      new_user
      new_pharmacy
      user
    }
    describe '非ログイン状態' do
      after { expect(current_path).to eq root_path }
      context 'users_controllerの全てのアクションに制限がある' do
        it 'indexアクションは呼び出せない' do
          visit users_path
          expect(page).to have_content 'ユーザー検索は薬局のみ実施可能です。'
        end

        it 'showアクションは呼び出せない' do
          visit user_path(new_user)
          expect(page).to have_content '他人のデータの参照はできません。'
        end

        it 'editアクションは呼び出せない' do
          visit edit_user_path(new_user)
          expect(page).to have_content '他人のデータの編集・削除などはできません。'
        end
      end
    end

    describe 'ユーザーでログイン状態' do
      before { user_login(new_user) }
      context 'users_controllerの一部のアクションに制限がある' do
        it 'indexアクションは呼び出せない' do
          visit users_path
          expect(page).to have_content 'ユーザー検索は薬局のみ実施可能です。'
          expect(current_path).to eq root_path
        end

        it 'showアクションは自分のもの以外は呼び出せない' do
          visit user_path(user)
          expect(page).to have_content '他人のデータの参照はできません。'
          expect(current_path).to eq root_path
        end

        it 'editアクションは自分のもの以外は呼び出せない' do
          visit edit_user_path(user)
          expect(page).to have_content '他人のデータの編集・削除などはできません。'
          expect(current_path).to eq root_path
        end
      end

      context 'users/registrations_controllerの一部のアクションに制限がある' do
        it 'newアクションは呼び出せない' do
          visit new_user_registration_path
          expect(page).to have_content 'すでにログインしています。'
          expect(current_path).to eq root_path
        end
      end

      context 'users/sessions_controllerの一部のアクションに制限がある' do
        it 'newアクションは呼び出せない' do
          visit new_user_session_path
          expect(page).to have_content 'すでにログインしています。'
          expect(current_path).to eq user_path(new_user)
        end
      end
    end

    describe '薬局でログイン状態' do
      before { pharmacy_login(new_pharmacy) }
      after { expect(current_path).to eq root_path }
      context 'users_controllerの一部のアクションに制限がある' do
        it 'editアクションは呼び出せない' do
          visit edit_user_path(user)
          expect(page).to have_content '他人のデータの編集・削除などはできません。'
        end
      end

      context 'users/registrations_controllerの全てのアクションに制限がある' do
        it 'newアクションは呼び出せない' do
          visit new_user_registration_path
          expect(page).to have_content '薬局をログアウトした際にお使い頂けます。'
        end

        it 'editアクションは呼び出せない' do
          visit edit_user_registration_path
          expect(page).to have_content '薬局をログアウトした際にお使い頂けます。'
        end
      end

      context 'users/sessions_controllerの一部のアクションに制限がある' do
        it 'newアクションは呼び出せない' do
          visit new_user_session_path
          expect(page).to have_content '薬局をログアウトした際にお使い頂けます。'
        end
      end
    end
  end
end
