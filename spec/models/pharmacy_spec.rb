require 'rails_helper'

RSpec.describe '薬局モデル機能', type: :model do
  let(:new_pharmacy) { FactoryBot.create(:new_pharmacy) }
  let(:pharmacy) { FactoryBot.create(:pharmacy) }

  describe 'モデルの作成' do
    context '最低限の新規登録' do
      it '必須項目を満たせばアカウントを登録できる' do
        expect(new_pharmacy).to be_valid
      end
    end

    context '名前のない新規登録' do
      it '名前がnilだとアカウント登録できない' do
        new_pharmacy.name = nil
        expect(new_pharmacy).not_to be_valid
      end
    end

    context 'メールアドレスのない新規登録' do
      it 'メールアドレスがnilだとアカウント登録できない' do
        new_pharmacy.email = nil
        expect(new_pharmacy).not_to be_valid
      end
    end

    context 'パスワードのある新規登録' do
      it 'パスワードが7文字だとアカウント登録できない' do
        new_pharmacy.password = "abcdefg"
        expect(new_pharmacy).not_to be_valid
      end
    end
  end

  describe 'モデルの編集' do
    context '全てのカラム' do
      it '全てのカラムに適切な値を入力すると登録できる' do
        expect(pharmacy).to be_valid
      end
    end

    context '郵便番号' do
      it '6文字の値を入力すると登録できない' do
        pharmacy.postcode = "123456"
        expect(pharmacy).not_to be_valid
      end

      it '8文字の値を入力すると登録できない' do
        pharmacy.postcode = "12345678"
        expect(pharmacy).not_to be_valid
      end

      it '数字以外の値を入力すると登録できない' do
        pharmacy.postcode = "1a3-5¥7"
        expect(pharmacy).not_to be_valid
      end
    end
    
    context '通常電話番号' do
      it '9文字の値を入力すると登録できない' do
        pharmacy.normal_telephone_number = "012345678"
        expect(pharmacy).not_to be_valid
      end

      it '10文字の値を入力すると登録できる' do
        pharmacy.normal_telephone_number = "0123456789"
        expect(pharmacy).to be_valid
      end

      it '11文字の値を入力すると登録できる' do
        pharmacy.normal_telephone_number = "01234567890"
        expect(pharmacy).to be_valid
      end

      it '12文字の値を入力すると登録できない' do
        pharmacy.normal_telephone_number = "012345678901"
        expect(pharmacy).not_to be_valid
      end

      it '数字以外の値を入力すると登録できない' do
        pharmacy.normal_telephone_number = "0a2#4%6(8"
        expect(pharmacy).not_to be_valid
      end
    end

    context '通常電話番号' do
      it '9文字の値を入力すると登録できない' do
        pharmacy.emergency_telephone_number = "012345678"
        expect(pharmacy).not_to be_valid
      end

      it '10文字の値を入力すると登録できる' do
        pharmacy.emergency_telephone_number = "0123456789"
        expect(pharmacy).to be_valid
      end

      it '11文字の値を入力すると登録できる' do
        pharmacy.emergency_telephone_number = "01234567890"
        expect(pharmacy).to be_valid
      end

      it '12文字の値を入力すると登録できない' do
        pharmacy.emergency_telephone_number = "012345678901"
        expect(pharmacy).not_to be_valid
      end

      it '数字以外の値を入力すると登録できない' do
        pharmacy.emergency_telephone_number = "0a2#4%6(8"
        expect(pharmacy).not_to be_valid
      end
    end
  end
end
