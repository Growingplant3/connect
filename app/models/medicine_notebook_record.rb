class MedicineNotebookRecord < ApplicationRecord
  belongs_to :user
  belongs_to :pharmacy
  validates :date_of_issue, :date_of_dispensing, :medical_institution_name, :doctor_name, presence: true
  validate :should_be_past

  def should_be_past
    if date_of_issue.present? && date_of_issue > Date.current
      errors.add(:date_of_issue, I18n.t('errors.messages.prescription_should_be_past'))
    end

    if date_of_dispensing.present? && date_of_dispensing > Date.current
      errors.add(:date_of_dispensing, I18n.t('errors.messages.prescription_should_be_past'))
    end
  end
end
