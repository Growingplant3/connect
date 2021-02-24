require 'rails_helper'

RSpec.describe '服用方法詳細モデル機能', type: :model do
  let(:take_method_detail) { create(:take_method_detail)}
  
  describe 'モデルの作成' do
    context '最低限の新規登録' do
      it '必須項目を満たせば医薬品を登録できる' do
        expect(take_method_detail).to be_valid
      end
    end

    context '新規登録できない' do
      it '服用時点が空だと登録できない' do
        take_method_detail[:style] = nil
        expect(take_method_detail).not_to be_valid
      end
    end
  end
end
