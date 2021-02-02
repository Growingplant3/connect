class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :pharmacy, foreign_key: true
      t.integer :day_of_the_week
      t.boolean :business, default: false
      t.datetime :opening_time
      t.datetime :closing_time
      
      t.timestamps
    end
  end
end
