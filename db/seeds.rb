first_user = User.create(name: "菊川", email: "kikukawa@gmail.com", password: "password", postcode: "8100000", address: "福岡県福岡市", telephone_number: "09212345678",
birthday: "1995-04-02".to_date, sex: 1, side_effect: "特に無し", allergy: "特に無し", sick: "特に無し", operation: "特に無し", note: "特に無し", role: 0)
User.create(name: "野菊", email: "nogiku@gmail.com", password: "password", postcode: "8100021", address: "福岡県北九州市", telephone_number: "09213572468",
birthday: "1995-08-02".to_date, sex: 2, side_effect: "特に無し", allergy: "特に無し", sick: "特に無し", operation: "特に無し", note: "特に無し", role: 0)
User.create(name: "菊池", email: "kikuchi@gmail.com", password: "password", postcode: "8100025", address: "福岡県久留米市", telephone_number: "09287654321",
birthday: "1965-01-02".to_date, sex: 1, side_effect: "特に無し", allergy: "特に無し", sick: "特に無し", operation: "特に無し", note: "特に無し", role: 0)
User.create(name: "菊川", email: "kikukiku@gmail.com", password: "password", postcode: "8100031", address: "福岡県筑後市", telephone_number: "09213579086",
birthday: nil, sex: 0, side_effect: "特に無し", allergy: "特に無し", sick: "特に無し", operation: "特に無し", note: "特に無し", role: 0)
developer1 = User.create(name: "武○製薬の開発者", email: "developer@gmail.com", password: "password", role: 1)
developer2 = User.create(name: "塩○義製薬の開発者", email: "developer2@gmail.com", password: "password", role: 1)
User.create(name: "管理者", email: "admin@gmail.com", password: "password", role: 2)

first_pharmacy = Pharmacy.create(name: "ひまわり薬局", email: "himawari@gmail.com", password: "password", postcode: "2720003", address: "千葉県市川市",
normal_telephone_number: "04712345678", emergency_telephone_number: "09012345678", note: "駐車場には限りがあります")
second_pharmacy = Pharmacy.create(name: "なのはな薬局", email: "nanohana@gmail.com", password: "password", postcode: "2720012", address: "千葉県市川市",
normal_telephone_number: "04756781234", emergency_telephone_number: "08012345678", note: "いつも明るいスタッフが対応します")
third_pharmacy = Pharmacy.create(name: "ひまな薬局", email: "himana@gmail.com", password: "password", postcode: "2700007", address: "千葉県松戸市",
normal_telephone_number: "04711112222", emergency_telephone_number: "09012341234", note: "12/30〜1/3はお休みです")
fourth_pharmacy = Pharmacy.create(name: "はな薬局", email: "hana@gmail.com", password: "password", postcode: "2730107", address: "千葉県鎌ヶ谷市",
normal_telephone_number: "0472234499", emergency_telephone_number: "08087656543", note: "全国どこの病院の処方箋でも受け付けております")

1.upto(4) do |pharmacy_identification|
  5.times do |index|
    Activity.create(pharmacy_id: pharmacy_identification, day_of_the_week: index, business: true, opening_time: "09:00", closing_time: "18:00")
  end
  Activity.create(pharmacy_id: pharmacy_identification, day_of_the_week: 5, business: "false", opening_time: nil, closing_time: nil)
  Activity.create(pharmacy_id: pharmacy_identification, day_of_the_week: 6, business: "false", opening_time: nil, closing_time: nil)
end

1.upto(4) do |user_identification|
  1.upto(4) do |pharmacy_identification|
    InformationDisclosure.create(user_id: user_identification, pharmacy_id: pharmacy_identification)
  end
end

azilsartan_10_mg = Medicine.create(name: "アジルバ錠", standard: 10, unit: 0, permission: true, user_id: developer1.id)
lansoprazole_od_15_mg = Medicine.create(name: "タケプロンOD錠", standard: 15, unit: 0, permission: true, user_id: developer1.id)
alogliptin_25_mg = Medicine.create(name: "ネシーナ錠", standard: 25, unit: 0, user_id: developer1.id)
ramelteon_8_mg = Medicine.create(name: "ロゼレム錠", standard: 8, unit: 0, user_id: developer1.id)
baloxavir_marboxil_10_mg = Medicine.create(name: "ゾフルーザ錠", standard: 20, unit: 0, user_id: developer2.id)