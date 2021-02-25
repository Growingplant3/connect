require 'rails_helper'

RSpec.describe '処方詳細管理機能', type: :system do
  let(:developer) { create(:developer) }
  let(:new_user) { create(:new_user) }
  let(:new_pharmacy) { create(:new_pharmacy) }
  let(:information_disclosure) { create(:information_disclosure, user_id: new_user.id, pharmacy_id: new_pharmacy.id) }
  let(:medicine_notebook_record) { create(:medicine_notebook_record, user_id: new_user.id, pharmacy_id: new_pharmacy.id) }
  let(:prescription_detail) { create(:prescription_detail, medicine_notebook_record_id: medicine_notebook_record.id) }
  let(:medicine) { create(:medicine, permission: "permit", user_id: developer.id) }
  let(:medicine_record_relation) { create(:medicine_record_relation, medicine_id: medicine.id, prescription_detail_id: prescription_detail.id) }
  let(:take_method_detail) { create(:take_method_detail) }
  let(:take_medicine_relation) { create(:take_medicine_relation, take_method_detail_id: take_method_detail.id, prescription_detail_id: prescription_detail.id) }

  describe '処方詳細作成' do
    context '薬局でログイン後' do
      before { 
        expect(PrescriptionDetail.count).to eq 0
        information_disclosure
        medicine_notebook_record
        medicine
        take_method_detail
        pharmacy_login(new_pharmacy)
        click_on 'ユーザー検索'
        click_on '新規登録ユーザー'
        click_on 'お薬手帳記録一覧を参照する'
        click_on '詳細を確認する'
      }
      it '必要事項を記入するとお薬手帳記録を作成できる' do
        click_on '処方薬を登録する'
        find('#prescription_detail_medicine_record_relations_attributes_0_medicine_id').set('sample_medicine1.5mg')
        find('#prescription_detail_take_medicine_relations_attributes_0_take_method_detail_id').set('朝食後')
        fill_in 'prescription_detail[prescription_days]', with: '1'
        fill_in 'prescription_detail[times]', with: '1'
        fill_in 'prescription_detail[daily_dose]', with: '1.0'
        fill_in 'prescription_detail[number_of_dose]', with: '1'
        click_on '登録する'
        expect(PrescriptionDetail.count).to eq 1
        expect(current_path).to eq user_medicine_notebook_record_path(new_user, medicine_notebook_record)
        expect(page).to have_content '処方薬を記録しました'
      end
    end
  end

  describe '処方詳細参照/編集/削除' do
    context '処方詳細作成後' do
      before {
      information_disclosure
      prescription_detail
      medicine_record_relation
      take_medicine_relation
      pharmacy_login(new_pharmacy)
      visit user_medicine_notebook_record_path(new_user, medicine_notebook_record)
      click_on 'sample_medicine1.5mg'
      }
      it '処方詳細を編集できる' do
        expect(current_path).to eq edit_user_medicine_notebook_record_prescription_detail_path(new_user, medicine_notebook_record, prescription_detail)
      end

      it '処方詳細を削除できる' do
        page.accept_confirm do
          click_on '処方薬を削除する'
        end
        expect(page).to have_content '処方薬の記録を削除しました'
        expect(current_path).to eq user_medicine_notebook_record_path(new_user, medicine_notebook_record)
      end
    end
  end
end
