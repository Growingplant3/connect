class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_validation :before_save, on: :create
  validates :name, presence: true
  validates :postcode, format: { with: /\A[0-9]+\z/ }, length: { is: 7 }, allow_nil: true
  validates :telephone_number, format: { with: /\A[0-9]+\z/ }, length: { in: 10..11 }, allow_nil: true
  validates :sex, inclusion: { in: %w(unknown male female) }
  validates :role, inclusion: { in: %w(normal developer master) }
  enum sex: { unknown: 0, male: 1, female: 2 }
  enum role: { normal: 0, developer: 1, master: 2 }

  def before_save
    self.postcode = DowncaseCallback.replace_to_half_num(self.postcode) if self.postcode.present?
    self.telephone_number = DowncaseCallback.replace_to_half_num(self.telephone_number) if self.telephone_number.present?
  end
end
