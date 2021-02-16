class CreatePrescriptionDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :prescription_details do |t|
      t.references :medicine_notebook_record, foreign_key: true
      t.integer :prescription_days, null: false
      t.integer :times, null: false
      t.float :daily_dose, null: false
      t.string :number_of_dose, null: false

      t.timestamps
    end
  end
end
