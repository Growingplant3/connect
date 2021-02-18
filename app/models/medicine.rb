class Medicine < ApplicationRecord
  belongs_to :user
  has_many :medicine_record_relations
  validates :name, :standard, :unit, presence: true
  enum unit: { mg: 0, μg: 1 }
  enum permission: { permit: true, unpermit: false }

  def self.authority_category(current_user)
    case current_user.role
    when "master"
      self.all
    when "developer"
      self.where(user_id: current_user.id)
    end
  end

  def self.choices
    hash = {}
    permit_medicines = self.where(permission: "permit")
    permit_medicines.pluck(:name).zip(permit_medicines.pluck(:id)) do |name, index|
      hash[name] = index
    end
    hash
  end
end
