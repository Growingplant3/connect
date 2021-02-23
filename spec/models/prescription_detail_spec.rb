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
  end
end
