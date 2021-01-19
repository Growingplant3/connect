class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :postcode, format: { with: /\A[0-9]+\z/ }, length: { is: 7 }
  validates :telephone_number, format: { with: /\A[0-9]+\z/ }
  validates :sex, :role, format: { with: /[0-2]/ }
end
