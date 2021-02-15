class MedicineNotebookRecord < ApplicationRecord
  belongs_to :user
  belongs_to :pharmacy
end
