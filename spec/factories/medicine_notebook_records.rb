FactoryBot.define do
  factory :medicine_notebook_record do
    date_of_issue { "2021-02-15" }
    date_of_dispensing { "2021-02-15" }
    medical_institution_name { "サンプル薬局" }
    doctor_name { "サンプル医師" }
    note { "特に無し" }
  end
end
