require 'rails_helper'

RSpec.describe 'ユーザーモデル機能', type: :model do
  let(:new_user) { FactoryBot.create(:new_user) }
  let(:user) { FactoryBot.create(:user) }
  
  describe 'モデルの作成' do
    context '最低限の新規登録' do
      it '必須項目を満たせばアカウント登録できる' do
        expect(new_user).to be_valid
      end
    end

    context '名前のない新規登録' do
      it '名前がnilだとアカウント登録できない' do
        new_user.name = nil
        expect(new_user).not_to be_valid
      end
    end

    context 'メールアドレスのない新規登録' do
      it 'メールアドレスがnilだとアカウント登録できない' do
        new_user.email = nil
        expect(new_user).not_to be_valid
      end
    end

    context 'パスワードのない新規登録' do
      it 'パスワードがnilだとアカウント登録できない' do
        new_user.password = nil
        expect(new_user).not_to be_valid
      end
    end

    context 'パスワードのある新規登録' do
      it 'パスワードが7文字だとアカウント登録できない' do
        new_user.password = "abcdefg"
        expect(new_user).not_to be_valid
      end
    end
  end

  describe 'モデルの編集' do
    context '全てのカラム' do
      it '全てのカラムに適切な値を入力すると登録できる' do
        expect(user).to be_valid
      end
    end

    context '郵便番号' do
      it '6文字の値を入力すると登録できない' do
        user.postcode = "123456"
        expect(user).not_to be_valid
      end

      it '8文字の値を入力すると登録できない' do
        user.postcode = "12345678"
        expect(user).not_to be_valid
      end

      it '数字以外の値を入力すると登録できない' do
        user.postcode = "1a3-5¥7"
        expect(user).not_to be_valid
      end
    end
    
    context '電話番号' do
      it '9文字の値を入力すると登録できない' do
        user.telephone_number = "012345678"
        expect(user).not_to be_valid
      end

      it '10文字の値を入力すると登録できる' do
        user.telephone_number = "0123456789"
        expect(user).to be_valid
      end

      it '11文字の値を入力すると登録できる' do
        user.telephone_number = "01234567890"
        expect(user).to be_valid
      end

      it '12文字の値を入力すると登録できない' do
        user.telephone_number = "012345678901"
        expect(user).not_to be_valid
      end

      it '数字以外の値を入力すると登録できない' do
        user.telephone_number = "0a2#4%6(8"
        expect(user).not_to be_valid
      end
    end

    context '性別' do
      it '男性で登録できる' do
        user.sex = "male"
        expect(user).to be_valid
      end

      it '女性で登録できる' do
        user.sex = "female"
        expect(user).to be_valid
      end

      it '未入力・男性・女性以外で登録できない' do
        expect{ user.sex = "another" }.to raise_error ArgumentError
      end
    end

    context '役割' do
      it '開発者で登録できる' do
        user.role = "developer"
        expect(user).to be_valid
      end

      it '管理者で登録できる' do
        user.role = "master"
        expect(user).to be_valid
      end

      it '未入力・男性・女性以外で登録できない' do
        expect{ user.sex = "another" }.to raise_error ArgumentError
      end
    end
  end

end
