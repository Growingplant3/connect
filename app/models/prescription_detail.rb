class PrescriptionDetail < ApplicationRecord
  belongs_to :medicine_notebook_record
  has_many :medicine_record_relations, dependent: :destroy
  has_many :connect_medicines, through: :medicine_record_relations, source: :medicine
  accepts_nested_attributes_for :medicine_record_relations, allow_destroy: true
  has_many :take_medicine_relations, dependent: :destroy
  has_many :connect_methods, through: :take_medicine_relations, source: :take_method_detail
  accepts_nested_attributes_for :take_medicine_relations, allow_destroy: true
  validates :prescription_days, :times, :daily_dose, :number_of_dose, presence: true
end
