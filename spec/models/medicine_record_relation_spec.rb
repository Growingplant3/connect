require 'rails_helper'

RSpec.describe "処方詳細・医薬品中間テーブル機能", type: :model do
  let(:new_user) { create(:new_user) }
  let(:new_pharmacy) { create(:new_pharmacy) }
  let(:medicine_notebook_record) { create(:medicine_notebook_record, user_id: new_user.id, pharmacy_id: new_pharmacy.id) }
  let(:prescription_detail) { create(:prescription_detail, medicine_notebook_record_id: medicine_notebook_record.id) }
  let(:medicine) { create(:medicine, user_id: new_user.id) }
  let(:medicine_record_relation) { create(:medicine_record_relation, prescription_detail_id: prescription_detail.id, medicine_id: medicine.id) }

  describe 'モデルの作成' do
    context '最低限の新規登録' do
      it '処方詳細と医薬品に紐づいた状態で、必須項目を満たせば中間テーブルを登録できる' do
        expect(medicine_record_relation).to be_valid
      end
    end

    context '新規登録の失敗' do
      after { expect(medicine_record_relation).not_to be_valid }
      it '処方詳細に紐づいていない状態では新規登録できない' do
        medicine_record_relation[:prescription_detail_id] = nil
      end

      it '医薬品に紐づいていない状態では新規登録できない' do
        medicine_record_relation[:medicine_id] = nil
      end
    end
  end
end
