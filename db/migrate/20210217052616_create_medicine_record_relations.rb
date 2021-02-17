class CreateMedicineRecordRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :medicine_record_relations do |t|
      t.references :medicine, foreign_key: true
      t.references :prescription_detail, foreign_key: true

      t.timestamps
    end
  end
end
