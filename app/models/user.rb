class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :postcode, format: { with: /\A[0-9]+\z/ }, length: { is: 7 }
  validates :telephone_number, format: { with: /\A[0-9]+\z/ }
  validates :sex, :role, format: { with: /[0-2]/ }
  enum sex: { unknown: 0, male: 1, female: 2 }
  enum role: { normal: 0, developer: 1, master: 2 }
end
