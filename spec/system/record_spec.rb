require 'rails_helper'

RSpec.describe 'お薬手帳記録管理機能', type: :system do
  let(:new_user) { create(:new_user) }
  let(:new_pharmacy) { create(:new_pharmacy) }
  let(:information_disclosure) { create(:information_disclosure, user_id: new_user.id, pharmacy_id: new_pharmacy.id) }
  let(:medicine_notebook_record) { create(:medicine_notebook_record, user_id: new_user.id, pharmacy_id: new_pharmacy.id) }
  
  describe 'お薬手帳記録作成' do
    context '薬局でログイン後' do
      before { 
        expect(MedicineNotebookRecord.count).to eq 0
        information_disclosure
        pharmacy_login(new_pharmacy)
        click_on 'ユーザー検索'
        click_on '新規登録ユーザー'
      }
      it '必要事項を記入するとお薬手帳記録を作成できる' do
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

    context 'お薬手帳が作成できない' do
      before { 
        expect(MedicineNotebookRecord.count).to eq 0
        information_disclosure
        pharmacy_login(new_pharmacy)
        click_on 'ユーザー検索'
        click_on '新規登録ユーザー'
        click_on 'お薬手帳記録を作成する'
      }
      after {
        expect(MedicineNotebookRecord.count).to eq 0
        expect(page).to have_content '1 個のエラーがあるため、保存できません'
      }
      it '処方箋発行日が未入力だとお薬手帳記録を作成できない' do
        find('#medicine_notebook_record_date_of_dispensing').set('002020-02-20')
        fill_in 'medicine_notebook_record[medical_institution_name]', with: 'サンプル病院'
        fill_in 'medicine_notebook_record[doctor_name]', with: 'サンプル医師'
        click_on '登録する'
      end

      it '処方箋調剤日が未入力だとお薬手帳記録を作成できない' do
        find('#medicine_notebook_record_date_of_issue').set('002020-02-20')
        fill_in 'medicine_notebook_record[medical_institution_name]', with: 'サンプル病院'
        fill_in 'medicine_notebook_record[doctor_name]', with: 'サンプル医師'
        click_on '登録する'
      end

      it '医療機関名が未入力だとお薬手帳記録を作成できない' do
        find('#medicine_notebook_record_date_of_issue').set('002020-02-20')
        find('#medicine_notebook_record_date_of_dispensing').set('002020-02-20')
        fill_in 'medicine_notebook_record[doctor_name]', with: 'サンプル医師'
        click_on '登録する'
      end

      it '保険医氏名が未入力だと奥薬手帳記録を作成できない' do
        find('#medicine_notebook_record_date_of_issue').set('002020-02-20')
        find('#medicine_notebook_record_date_of_dispensing').set('002020-02-20')
        fill_in 'medicine_notebook_record[medical_institution_name]', with: 'サンプル病院'
        click_on '登録する'
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
