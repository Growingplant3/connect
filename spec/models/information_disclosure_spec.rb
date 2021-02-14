require 'rails_helper'
RSpec.describe InformationDisclosure, type: :model do
  let(:new_user) { create(:new_user) }
  let(:new_pharmacy) { create(:new_pharmacy) }
  let(:information_disclosure) { create(:information_disclosure, user_id: new_user.id, pharmacy_id: new_pharmacy.id) }
  before { expect(InformationDisclosure.all.count).to eq 0 }

  describe 'モデルの作成' do
    it 'ユーザーと薬局に紐づいた状態で情報解除モデルを作成できる' do
      information_disclosure
      expect(InformationDisclosure.all.count).to eq 1
      expect(InformationDisclosure.first.user).to eq new_user
      expect(InformationDisclosure.first.pharmacy).to eq new_pharmacy
    end    
  end
  
  describe 'モデルの削除' do
    context '情報開示モデル作成後' do
      before { 
        information_disclosure
      }
      after { expect(InformationDisclosure.all.count).to eq 0 }
      it '作成された情報開示モデルを削除できる' do
        information_disclosure.destroy
      end
      it 'ユーザーが削除されると紐づいている情報開示モデルも削除される' do
        new_user.destroy
      end
      it '薬局が削除されると紐づいている情報開示モデルも削除される' do
        new_pharmacy.destroy
      end
    end
  end
end
