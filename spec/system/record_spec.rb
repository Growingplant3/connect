require 'rails_helper'

RSpec.describe 'お薬手帳記録管理機能', type: :system do
  let(:new_user) { create(:new_user) }
  let(:new_pharmacy) { create(:new_pharmacy) }
  let(:information_disclosure) { create(:information_disclosure, user_id: new_user.id, pharmacy_id: new_pharmacy.id) }
  let(:medicine_notebook_record) { create(:medicine_notebook_record, user_id: new_user.id, pharmacy_id: new_pharmacy.id) }
  
  describe 'お薬手帳記録作成' do
    context '薬局でログイン後' do
      before { 
        information_disclosure
        pharmacy_login(new_pharmacy)
      }
      it '必要事項を記入するとお薬手帳記録を作成できる' do
        expect(MedicineNotebookRecord.count).to eq 0
        click_on 'ユーザー検索'
        click_on '新規登録ユーザー'
        click_on 'お薬手帳記録を作成する'
        find('#medicine_notebook_record_date_of_issue').set('002020-02-20')
        find('#medicine_notebook_record_date_of_dispensing').set('002020-02-20')
        fill_in 'medicine_notebook_record[medical_institution_name]', with: 'サンプル病院'
        fill_in 'medicine_notebook_record[doctor_name]', with: 'サンプル医師'
        click_on '登録する'
        expect(MedicineNotebookRecord.count).to eq 1
        expect(current_path).to eq user_medicine_notebook_records_path(new_user)
        expect(page).to have_content 'お薬手帳記録を作成しました'
      end
    end
  end
    
  describe 'お薬手帳記録参照/更新/削除' do
    context '薬局でログインし、お薬手帳記録を作成後' do
      before { 
        information_disclosure
        medicine_notebook_record
        pharmacy_login(new_pharmacy)
        click_on 'ユーザー検索'
        click_on '新規登録ユーザー'
        click_on 'お薬手帳記録一覧を参照する'
      }
      it 'お薬手帳記録を参照できる' do
        click_on '詳細を確認する'
        expect(current_path).to eq user_medicine_notebook_record_path(new_user, medicine_notebook_record)
        expect(page).to have_content "#{new_user.name}" && "#{new_pharmacy.name}" && "#{medicine_notebook_record.doctor_name}"
      end

      it 'お薬手帳記録を更新できる' do
        click_on '詳細を確認する'
        click_on '更新する'
        expect(current_path).to eq edit_user_medicine_notebook_record_path(new_user, medicine_notebook_record)
      end

      it 'お薬手帳記録を削除できる' do
        click_on '詳細を確認する'
        page.accept_confirm do
          click_on '削除する'
        end
        expect(current_path).to eq user_medicine_notebook_records_path(new_user)
        expect(page).to have_content 'お薬手帳記録を削除しました'
      end
    end
  end
end
