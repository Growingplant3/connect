FactoryBot.define do
  factory :activity do
    day_of_the_week { 1 }
    association :pharmacy
  end

  factory :first_activity, class: Activity do
    day_of_the_week { 0 }
    business { "true" }
    opening_time { "09:00" }
    closing_time { "19:00" }
    association :pharmacy
  end

  factory :last_activity, class: Activity do
    day_of_the_week { 6 }
    business { "false" }
    opening_time { nil }
    closing_time { nil }
    association :pharmacy
  end
end
