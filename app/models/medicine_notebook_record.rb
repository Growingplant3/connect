class MedicineNotebookRecord < ApplicationRecord
  has_many :prescription_details, dependent: :destroy
  accepts_nested_attributes_for :prescription_details, allow_destroy: true
  belongs_to :user
  belongs_to :pharmacy
  validates :date_of_issue, :date_of_dispensing, presence: true
  validates :medical_institution_name, :doctor_name, length: { maximum: 20 }, presence: true
  validates_associated :prescription_details
  validate :should_be_past
  scope :descending_order, -> { order(date_of_issue: "desc") }

  def should_be_past
    if date_of_issue.present? && date_of_issue > Date.current
      errors.add(:date_of_issue, I18n.t('errors.messages.prescription_should_be_past'))
    end

    if date_of_dispensing.present? && date_of_dispensing > Date.current
      errors.add(:date_of_dispensing, I18n.t('errors.messages.prescription_should_be_past'))
    end
  end
end
