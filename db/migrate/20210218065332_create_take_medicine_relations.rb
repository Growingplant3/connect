class CreateTakeMedicineRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :take_medicine_relations do |t|
      t.references :prescription_detail, foreign_key: true
      t.references :take_method_detail, foreign_key: true

      t.timestamps
    end
  end
end
