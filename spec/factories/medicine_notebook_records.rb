FactoryBot.define do
  factory :medicine_notebook_record do
    user_id { 1 }
    pharmacy_id { 1 }
    date_of_issue { "2021-02-15" }
    date_of_dispensing { "2021-02-15" }
    medical_institution_name { "MyString" }
    doctor_name { "MyString" }
    note { "MyText" }
  end
end
