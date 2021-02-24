require 'rails_helper'

RSpec.describe "処方詳細モデル機能", type: :model do
  let(:new_user) { create(:new_user) }
  let(:new_pharmacy) { create(:new_pharmacy) }
  let(:medicine_notebook_record) { create(:medicine_notebook_record, user_id: new_user.id, pharmacy_id: new_pharmacy.id) }
  let(:prescription_detail) { create(:prescription_detail, medicine_notebook_record_id: medicine_notebook_record.id) }

  describe 'モデルの作成' do
    context '最低限の新規登録' do
      it 'お薬手帳記録に紐づいた状態で、必須項目を満たせば処方詳細を登録できる' do
        expect(prescription_detail).to be_valid
      end
    end

    context '新規登録の失敗' do
      after { expect(prescription_detail).not_to be_valid }
      it 'お薬手帳に紐づかない状態では新規登録できない' do
        prescription_detail[:medicine_notebook_record_id] = nil
      end

      it '処方日数が未入力だと新規登録できない' do
        prescription_detail[:prescription_days] = nil
      end

      it '服用回数が未入力だと新規登録できない' do
        prescription_detail[:times] = nil
      end

      it '1日量が未入力だと新規登録できない' do
        prescription_detail[:daily_dose] = nil
      end

      it '1回量が未入力だと新規登録できない' do
        prescription_detail[:number_of_dose] = nil
      end
    end
  end
end
