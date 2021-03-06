class Activity < ApplicationRecord
  validates :business, inclusion: { in: %w(true false) }
  validates :day_of_the_week, inclusion: { in: %w(monday tuesday wednesday thursday friday saturday sunday) }
  enum business: { true: true, false: false }
  enum day_of_the_week: { monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4, saturday: 5, sunday: 6 }
  belongs_to :pharmacy
end
