FactoryBot.define do
  factory :prescription_detail do
    prescription_days { 1 }
    times { 1 }
    daily_dose { 1.0 }
    number_of_dose { "1" }
  end
end
