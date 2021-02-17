class PrescriptionDetail < ApplicationRecord
  belongs_to :medicine_notebook_record
  validates :prescription_days, :times, :daily_dose, :number_of_dose, presence: true
end
