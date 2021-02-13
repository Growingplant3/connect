require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:new_user) { create(:new_user) }
  let(:new_pharmacy) { create(:new_pharmacy) }
  let(:like) { create(:like, user_id: new_user.id, pharmacy_id: new_pharmacy.id) }

  before { expect(Like.all.count).to eq 0 }
  describe 'モデルの作成' do
    it 'ユーザーと薬局に紐づいた状態でいいねを作成できる' do
      like
      expect(Like.all.count).to eq 1
      expect(Like.first.user).to eq new_user
      expect(Like.first.pharmacy).to eq new_pharmacy
    end
  end

  describe 'モデルの削除' do
    context 'いいね作成後' do
      before { 
        like
      }
      after { expect(Like.all.count).to eq 0 }
      it '作成されたいいねを削除できる' do
        like.destroy
      end

      it 'ユーザーが削除されると紐づいているいいねも削除される' do
        new_user.destroy
      end

      it '薬局が削除されると紐づいているいいねも削除される' do
        new_pharmacy.destroy
      end
    end
  end
end
