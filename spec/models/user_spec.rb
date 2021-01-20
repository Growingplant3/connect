require 'rails_helper'

RSpec.describe 'ユーザーモデル機能', type: :model do
  let(:new_user) { FactoryBot.create(:new_user) }
  let(:user) { FactoryBot.create(:user) }
  
  describe 'モデルの作成' do
    context '新規登録' do
      it '必須項目を満たせばアカウント登録できる' do
        expect(new_user).to be_valid
      end
    end
  end
end
