class CreateMedicineNotebookRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :medicine_notebook_records do |t|
      t.references :user, foreign_key: true
      t.references :pharmacy, foreign_key: true
      t.date :date_of_issue, null: false
      t.date :date_of_dispensing, null: false
      t.string :medical_institution_name, null: false
      t.string :doctor_name, null: false
      t.text :note

      t.timestamps
    end
  end
end
