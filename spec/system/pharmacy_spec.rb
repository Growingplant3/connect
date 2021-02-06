require 'rails_helper'
RSpec.describe '薬局管理機能', type: :system do
  let(:new_pharmacy) { create(:new_pharmacy) }
  let(:sunflower_pharmacy) { create(:sunflower_pharmacy) }
  let(:rape_blossoms_pharmacy) { create(:rape_blossoms_pharmacy) }
  let(:free_time_pharmacy) { create(:free_time_pharmacy) }
  let(:flower_pharmacy) { create(:flower_pharmacy) }
  let(:first_user) { create(:first_user) }
  let(:second_user) { create(:second_user) }
  let(:third_user) { create(:third_user) }
  let(:fourth_user) { create(:fourth_user) }
  let(:developer) { create(:developer) }
  let(:admin) { create(:admin) }

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

    describe 'ユーザー検索機能' do
      before {
        first_user
        second_user
        third_user
        fourth_user
        developer
        admin
        visit users_path
      }
      after { expect(User.count).to eq 6 }
      context '薬局はユーザー検索ができる' do
        it '性別が未登録で完全一致検索ができる' do
          find('#q_sex_eq').find("option[value='0']").select_option
          click_on '検索'
          expect(page).to have_content '菊川' && '福岡県筑後市'
        end

        it '性別が男性で完全一致検索ができる' do
          find('#q_sex_eq').find("option[value='1']").select_option
          click_on '検索'
          expect(page).to have_content '菊川' && '菊池'
        end

        it '性別が女性で完全一致検索ができる' do
          find('#q_sex_eq').find("option[value='2']").select_option
          click_on '検索'
          expect(page).to have_content '野菊'
        end

        it 'ユーザー名と性別を組み合わせて検索ができる' do
          find('#q_name_cont').set('菊川')
          find('#q_sex_eq').find("option[value='1']").select_option
          click_on '検索'
          expect(page).to have_content '菊川' && '福岡県福岡市'
        end

        it '電話番号と性別を組み合わせて検索ができる' do
          find('#q_telephone_number_eq').set('09212345678')
          find('#q_sex_eq').find("option[value='1']").select_option
          click_on '検索'
          expect(page).to have_content '菊川' && '福岡県福岡市'
        end

        it 'メールアドレスと性別を組み合わせて検索ができる' do
          find('#q_email_cont').set('kikukawa@gmail.com')
          find('#q_sex_eq').find("option[value='1']").select_option
          click_on '検索'
          expect(page).to have_content '菊川' && '福岡県福岡市'
        end

        it '西暦を指定して誕生日の範囲検索ができる' do
          find('#q_birthday_cont').set('1995')
          find('#q_sex_eq')..find("option[value='2']").select_option
          click_on '検索'
          expect(page).to have_content '野菊' && '福岡県北九州市'
        end

        it '西暦と月を指定して誕生日の範囲検索ができる' do
          find('#q_birthday_cont').set('199508')
          find('#q_sex_eq')..find("option[value='2']").select_option
          click_on '検索'
          expect(page).to have_content '野菊' && '福岡県北九州市'
        end
      end

      context '薬局はユーザー検索できない' do
        it 'ユーザー名が該当しなければ検索できない' do
          find('#q_name_cont').set('竹林')
          find('#q_sex_eq').find("option[value='1']").select_option
          find('#q_email_cont').set('kikukawa@gmail.com')
          click_on '検索'
          expect(page).not_to have_content '菊川' && '福岡県福岡市'
        end

        it '誕生日が範囲に合致しなければ検索できない' do
          find('#q_birthday_cont').set('2000')
          find('#q_sex_eq')..find("option[value='2']").select_option
          click_on '検索'
          expect(page).not_to have_content '野菊' && '福岡県北九州市'
        end

        it '電話番号が一致しなければ検索できない' do
          find('#q_sex_eq').find("option[value='1']").select_option
          find('#q_telephone_number_eq').set("07012345678")
          find('#q_email_cont').set('kikukawa@gmail.com')
          click_on '検索'
          expect(page).not_to have_content '菊川' && '福岡県福岡市'
        end

        it 'メールアドレスが一致しなければ検索できない' do
          find('#q_email_cont').set('nonogiku')
          find('#q_sex_eq')..find("option[value='2']").select_option
          click_on '検索'
          expect(page).not_to have_content '野菊' && '福岡県北九州市'
        end

        it '管理者と開発者は検索できない' do
          find('#q_sex_eq')..find("option[value='0']").select_option
          click_on '検索'
          expect(page).not_to have_content '管理者' && '開発者'
        end
      end
    end
  end

  describe '薬局検索機能' do
    before {
      sunflower_pharmacy
      rape_blossoms_pharmacy
      free_time_pharmacy
      flower_pharmacy
      visit pharmacies_path
    }
    after { expect(Pharmacy.count).to eq 4 }
    context '全てのアプリ利用者は薬局検索機能を使用することができる' do
      it '通常電話番号での完全一致検索ができる' do
        find('#q_normal_telephone_number_or_emergency_telephone_number_eq').set('04712345678')
        click_on '検索'
        expect(page).to have_content 'ひまわり薬局'
        expect(page).not_to have_content 'なのはな薬局' && 'ひまな薬局' && 'はな薬局'
      end

      it '緊急事電話番号での完全一致検索ができる' do
        find('#q_normal_telephone_number_or_emergency_telephone_number_eq').set('09012345678')
        click_on '検索'
        expect(page).to have_content 'ひまわり薬局'
        expect(page).not_to have_content 'なのはな薬局' && 'ひまな薬局' && 'はな薬局'
      end

      it '薬局名でのあいまい検索ができる' do
        find('#q_name_cont').set('ひま')
        click_on '検索'
        expect(page).to have_content 'ひまわり薬局' && 'ひまな薬局'
        expect(page).not_to have_content 'なのはな薬局' && 'はな薬局'
      end

      it '住所でのあいまい検索ができる' do
        find('#q_address_cont').set('松戸市')
        click_on '検索'
        expect(page).to have_content 'ひまな薬局'
        expect(page).not_to have_content 'ひまわり薬局' && 'なのはな薬局' && 'はな薬局'
      end

      it 'メールアドレスでのあいまい検索ができる' do
        find('#q_email_cont').set('hana')
        click_on '検索'
        expect(page).to have_content 'なのはな薬局' && 'はな薬局'
        expect(page).not_to have_content 'ひまわり薬局' && 'ひまな薬局'
      end

      it 'あいまい検索を組み合わせて絞り込みができる' do
        find('#q_name_cont').set('ひま')
        find('#q_address_cont').set('市川市')
        click_on '検索'
        expect(page).to have_content 'ひまわり薬局'
        expect(page).not_to have_content 'なのはな薬局' && 'ひまな薬局' && 'はな薬局'
      end
    end
  end
end
