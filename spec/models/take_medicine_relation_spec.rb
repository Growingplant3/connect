require 'rails_helper'

RSpec.describe "服用方法中間テーブル機能", type: :model do
  let(:new_user) { create(:new_user) }
  let(:new_pharmacy) { create(:new_pharmacy) }
  let(:medicine_notebook_record) { create(:medicine_notebook_record, user_id: new_user.id, pharmacy_id: new_pharmacy.id) }
  let(:prescription_detail) { create(:prescription_detail, medicine_notebook_record_id: medicine_notebook_record.id) }
  let(:take_method_detail) { create(:take_method_detail) }
  let(:take_medicine_relation) { create(:take_medicine_relation, prescription_detail_id: prescription_detail.id, take_method_detail_id: take_method_detail.id) }

  describe 'モデルの作成' do
    context '最低限の新規登録' do
      it '処方詳細と服用方法詳細に紐づいた状態で、必須項目を満たせば中間テーブルを登録できる' do
        expect(take_medicine_relation).to be_valid
      end
    end

    context '新規登録の失敗' do
      after { expect(take_medicine_relation).not_to be_valid }
      it '処方詳細に紐づいていない状態では新規登録できない' do
        take_medicine_relation[:prescription_detail_id] = nil
      end

      it '服用方法詳細に紐づいていない状態では新規登録できない' do
        take_medicine_relation[:take_method_detail_id] = nil
      end
    end
  end
end
