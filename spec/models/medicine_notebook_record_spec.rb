require 'rails_helper'

RSpec.describe 'お薬手帳記録作成機能', type: :model do
  let(:new_user) { create(:new_user) }
  let(:new_pharmacy) { create(:new_pharmacy) }
  let(:medicine_notebook_record) { create(:medicine_notebook_record, user_id: new_user.id, pharmacy_id: new_pharmacy.id) }
  
  describe 'モデルの作成' do
    context '最低限の新規登録' do
      it 'ユーザーと薬局に紐づいた状態で、必須項目を満たせばお薬手帳記録を登録できる' do
        expect(medicine_notebook_record).to be_valid
      end
    end

    context '新規登録の失敗' do
      it 'ユーザーに紐づいていない状態ではお薬手帳記録は登録できない' do
        medicine_notebook_record[:user_id] = nil
        expect(medicine_notebook_record).not_to be_valid
      end

      it '薬局に紐づいていない状態ではお薬手帳記録は登録できない' do
        medicine_notebook_record[:pharmacy_id] = nil
        expect(medicine_notebook_record).not_to be_valid
      end

      it '処方箋発行日が未入力ではお薬手帳記録は登録できない' do
        medicine_notebook_record[:date_of_issue] = nil
        expect(medicine_notebook_record).not_to be_valid
      end

      it '処方箋調剤日が未入力ではお薬手帳記録は登録できない' do
        medicine_notebook_record[:date_of_dispensing] = nil
        expect(medicine_notebook_record).not_to be_valid
      end

      it '医療機関名が未入力ではお薬手帳記録は登録できない' do
        medicine_notebook_record[:medical_institution_name] = nil
        expect(medicine_notebook_record).not_to be_valid
      end

      it '保険医氏名が未入力ではお薬手帳記録は登録できない' do
        medicine_notebook_record[:doctor_name] = nil
        expect(medicine_notebook_record).not_to be_valid
      end
    end
  end
end
