class CreateTakeMethodDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :take_method_details do |t|
      t.string :style, null: false

      t.timestamps
    end
  end
end
