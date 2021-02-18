class TakeMedicineRelation < ApplicationRecord
  belongs_to :prescription_detail
  belongs_to :take_method_detail
end
