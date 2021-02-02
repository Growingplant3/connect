FactoryBot.define do
  factory :new_pharmacy, class: Pharmacy do
    name { "新規登録薬局" }
    email { "new_pharmacy@gmail.com" }
    password { "new_pharmacy" }
  end

  factory :pharmacy do
    name { "あおぞら薬局" }
    postcode { "2608667" }
    address { "千葉市中央区市場町1-1" }
    normal_telephone_number { "0611112222" }
    emergency_telephone_number { "09011112222" }
    note { "駐車場には限りがあります。" }
    email { "pharmacy@gmail.com" }
    password { "pharmacy" }
  end
end
