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

  factory :sunflower_pharmacy, class: Pharmacy do
    name { "ひまわり薬局" }
    email { "himawari@gmail.com" }
    password { "password" }
    address { "千葉県市川市" }
    normal_telephone_number { "04712345678" }
    emergency_telephone_number { "09012345678" }
  end

  factory :rape_blossoms_pharmacy, class: Pharmacy do
    name { "なのはな薬局" }
    email { "nanohana@gmail.com" }
    password { "password" }
    address { "千葉県市川市" }
    normal_telephone_number { "04756781234" }
    emergency_telephone_number { "08012345678" }
  end

  factory :free_time_pharmacy, class: Pharmacy do
    name { "ひまな薬局" }
    email { "himana@gmail.com" }
    password { "password" }
    address { "千葉県松戸市" }
    normal_telephone_number { "04711112222" }
    emergency_telephone_number { "09012341234" }
  end

  factory :flower_pharmacy, class: Pharmacy do
    name { "はな薬局" }
    email { "hana@gmail.com" }
    password { "password" }
    postcode { "2730107" }
    address { "千葉県鎌ヶ谷市" }
    normal_telephone_number { "0472234499" }
    emergency_telephone_number { "08087656543" }
  end
end
