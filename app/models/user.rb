class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_validation :before_save, on: :update
  has_many :likes, dependent: :destroy
  has_many :information_disclosures, dependent: :destroy
  validates :name, presence: true
  validates :postcode, format: { with: /\A[0-9]+\z/ }, length: { is: 7 }, allow_blank: true
  validates :telephone_number, format: { with: /\A[0-9]+\z/ }, length: { in: 10..11 }, allow_blank: true
  validates :sex, inclusion: { in: %w(unknown male female) }
  validates :role, inclusion: { in: %w(normal developer master) }
  validate :should_be_past, on: :update
  enum sex: { unknown: 0, male: 1, female: 2 }
  enum role: { normal: 0, developer: 1, master: 2 }
  scope :standard_exclusion, -> { where(role: 0) }

  def before_save
    self.postcode = DowncaseCallback.replace_to_half_num(self.postcode) if self.postcode.present?
    self.telephone_number = DowncaseCallback.replace_to_half_num(self.telephone_number) if self.telephone_number.present?
  end

  def should_be_past
    if birthday.present? && birthday > Date.current
      errors.add(:birthday, I18n.t('errors.messages.should_be_past'))
    end
  end

  def self.set_gender
    gender_choices = {}
    self.sexes_i18n.values.each_with_index do |value, index|
      gender_choices[value] = index
    end
    gender_choices
  end

  def self.selection(params_q)
    return self.all if params_q.blank? || params_q[:birthday_cont].blank?
    string = params_q[:birthday_cont]
    params_q[:birthday_cont] = ""
    if self.regular_expression_confirmation(string)
      digits = string.length
      search_range = self.judgment_of_characters_and_conversion(string,digits)
      return self.where(birthday: search_range) unless search_range.nil?
    end
    self.all
  end

  def self.regular_expression_confirmation(string)
    string =~ /\A[0-9]+\z/
  end

  def self.judgment_of_characters_and_conversion(string,length)
    case length
    when 6
      if string =~ /[0-9]{4}(0[1-9]|1[0-2])/
        from = (string + "01").to_date
        to = from.end_of_month
        return from..to
      end
    when 4
      if string =~ /[0-9]{4}/
        from = (string + "0101").to_date
        to = from.end_of_year
        return from..to
      end
    end
    nil
  end
end
