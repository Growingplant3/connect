require 'rails_helper'

RSpec.describe '薬局モデル機能', type: :model do
  let(:developer) { create(:developer)}
  let(:admin) { create(:admin) }
  let(:developer_medicine) { create(:medicine, user_id: developer.id) }
  let(:admin_medicine) { create(:medicine, user_id: admin.id) }
  
  describe 'モデルの作成' do
    context '最低限の新規登録' do
      it '開発者に紐づいた状態で、必須項目を満たせば医薬品を登録できる' do
        expect(developer_medicine).to be_valid
      end

      it '管理者に紐づいた状態で、必須項目を満たせば医薬品を登録できる' do
        expect(developer_medicine).to be_valid
      end
    end

    context '新規登録の失敗' do
      it '薬品名がないと登録できない' do
        developer_medicine.name = nil
        expect(developer_medicine).not_to be_valid
      end

      it '規格がないと登録できない' do
        developer_medicine.standard = nil
        expect(developer_medicine).not_to be_valid
      end

      it '単位がないと登録できない' do
        developer_medicine.unit = nil
        expect(developer_medicine).not_to be_valid
      end
      
      it '単位がμgまたはmgでなければ登録できない' do
        expect{ developer_medicine[:unit] = "another" }.to raise_error ArgumentError
      end

      it '採用状態がpermitまたはunpermitでなければ登録できない' do
        expect{ developer_medicine[:permission] = "another" }.to raise_error ArgumentError
      end

      it 'userに紐づいていない状態だと登録できない' do
        developer_medicine.user_id = nil
        expect(developer_medicine).not_to be_valid
      end
    end
  end
end
