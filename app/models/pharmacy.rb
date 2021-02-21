class Pharmacy < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_validation :before_save, on: :update
  has_many :likes, dependent: :destroy
  has_many :information_disclosures, dependent: :destroy
  has_many :medicine_notebook_records, dependent: :destroy
  validates :name, length: { maximum: 20 }, presence: true
  validates :address, length: { maximum: 50 }
  validates :postcode, format: { with: /\A[0-9]+\z/ }, length: { is: 7 }, allow_blank: true
  validates :normal_telephone_number, format: { with: /\A[0-9]+\z/ }, length: { in: 10..11 }, allow_blank: true
  validates :emergency_telephone_number, format: { with: /\A[0-9]+\z/ }, length: { in: 10..11 }, allow_blank: true
  has_many :activities, dependent: :destroy
  accepts_nested_attributes_for :activities, allow_destroy: true

  def before_save
    self.postcode = DowncaseCallback.replace_to_half_num(self.postcode) if self.postcode.present?
    self.normal_telephone_number = DowncaseCallback.replace_to_half_num(self.normal_telephone_number) if self.normal_telephone_number.present?
    self.emergency_telephone_number = DowncaseCallback.replace_to_half_num(self.emergency_telephone_number) if self.emergency_telephone_number.present?
  end

  def self.have_search_permission(session_pharmacy_id)
    self.find(session_pharmacy_id).information_disclosures.pluck(:user_id)
  end
end
