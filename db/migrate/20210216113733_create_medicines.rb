class CreateMedicines < ActiveRecord::Migration[5.2]
  def change
    create_table :medicines do |t|
      t.string :name, null: false
      t.float :standard, null: false
      t.integer :unit, null: false
      t.boolean :permission, null: false, default: false
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
