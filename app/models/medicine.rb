class Medicine < ApplicationRecord
  belongs_to :user
  has_many :medicine_record_relations
  validates :standard, :unit, presence: true
  validates :name, length: { maximum: 50 }, presence: true
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
    permit_medicines = Medicine.where(permission: "permit")
    permit_medicines.pluck(:id, :name, :standard, :unit).each do | id, name, standard, unit |
      hash["#{name}#{standard}#{unit}"] = id
    end
    hash
  end
end
