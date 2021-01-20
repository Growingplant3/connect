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
end
