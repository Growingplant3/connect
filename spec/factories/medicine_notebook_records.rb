FactoryBot.define do
  factory :medicine_notebook_record do
    date_of_issue { "2021-02-20" }
    date_of_dispensing { "2021-02-20" }
    medical_institution_name { "サンプル病院" }
    doctor_name { "サンプル医師" }
    note { "特に無し" }
  end
end
