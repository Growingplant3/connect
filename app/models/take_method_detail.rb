class TakeMethodDetail < ApplicationRecord
  validates :style, presence: true
  has_many :take_medicine_relations

  def self.to_hash_for_choices
    hash = {}
    self.pluck(:style).zip(self.pluck(:id)) do |style, index|
      hash[style] = index
    end
    hash
  end
end
