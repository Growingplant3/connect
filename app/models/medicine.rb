class Medicine < ApplicationRecord
  belongs_to :user
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
end
