class CreateInformationDisclosures < ActiveRecord::Migration[5.2]
  def change
    create_table :information_disclosures do |t|
      t.integer :user_id
      t.integer :pharmacy_id

      t.timestamps
    end
  end
end
