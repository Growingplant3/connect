FactoryBot.define do
  factory :medicine do
    name { "MyString" }
    standard { 1.5 }
    unit { 1 }
    permission { false }
  end
end
