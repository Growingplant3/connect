require 'rails_helper'

RSpec.describe 'お薬手帳記録作成機能', type: :model do
  let(:new_user) { create(:new_user) }
  let(:new_pharmacy) { create(:new_pharmacy) }
  let(:medicine_notebook_record) { create(:medicine_notebook_record, user_id: new_user.id, pharmacy_id: new_pharmacy.id) }
  
  describe 'モデルの作成' do
    context '最低限の新規登録' do
      it 'ユーザーと薬局に紐づいた状態で、必須項目を満たせば医薬品を登録できる' do
        expect(medicine_notebook_record).to be_valid
      end
    end
  end
end
