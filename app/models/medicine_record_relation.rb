class MedicineRecordRelation < ApplicationRecord
  belongs_to :medicine
  belongs_to :prescription_detail
end
