FactoryBot.define do
  factory :prescription_detail do
    medicine_notebook_record { nil }
    prescription_days { 1 }
    times { 1 }
    daily_dose { 1.5 }
    number_of_dose { "MyString" }
  end
end
