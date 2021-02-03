require 'rails_helper'

RSpec.describe '開局状況モデル機能', type: :model do
  let(:activity) { create(:activity) }
  let(:first_activity) { create(:first_activity) }
  let(:last_activity) { create(:last_activity) }

  describe 'モデルの作成' do
    context '最低限の新規登録' do
      it '薬局に紐づいていれば登録できる' do
        expect(activity).to be_valid
      end
    end
  end

  describe 'モデルの編集' do
    context '全てのカラム' do
      it '全てのカラムに適切な値を入力すると編集できる' do
        expect(first_activity).to be_valid
      end
    end

    context '開局時間カラムと閉局時間カラム' do
      after { expect(last_activity).to be_valid }
      it 'どちらもnilであっても編集できる' do
      end

      it '開局時間カラムの値だけを入力しても編集できる' do
        last_activity.opening_time = "10:00"
      end

      it '閉局時間カラムの値だけを入力しても編集できる' do
        last_activity.closing_time = "20:00"
      end
    end

    context '営業中カラム' do
      it '開局・お休み以外で登録できない' do
        expect{ activity.business = "another" }.to raise_error ArgumentError
      end
    end

    context '曜日カラム' do
      it '月火水木金土日以外で登録できない' do
        expect{ activity.day_of_the_week = "another" }.to raise_error ArgumentError
      end
    end
  end
end
