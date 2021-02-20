first_user = User.create(name: "菊川洋介", email: "kikukawa@gmail.com", password: "password", postcode: "8100000", address: "福岡県福岡市", telephone_number: "09212345678",
birthday: "1995-04-02".to_date, sex: 1, side_effect: "特に無し", allergy: "特に無し", sick: "特に無し", operation: "特に無し", note: "特に無し", role: 0)
second_user = User.create(name: "野菊千秋", email: "nogiku@gmail.com", password: "password", postcode: "8100021", address: "福岡県北九州市", telephone_number: "09213572468",
birthday: "1962-08-02".to_date, sex: 2, side_effect: "特に無し", allergy: "特に無し", sick: "特に無し", operation: "特に無し", note: "特に無し", role: 0)
User.create(name: "菊池稔", email: "kikuchi@gmail.com", password: "password", postcode: "8100025", address: "福岡県久留米市", telephone_number: "09287654321",
birthday: "1965-01-02".to_date, sex: 1, side_effect: "特に無し", allergy: "特に無し", sick: "特に無し", operation: "特に無し", note: "特に無し", role: 0)
User.create(name: "菊川修二", email: "kikukiku@gmail.com", password: "password", postcode: "8100031", address: "福岡県筑後市", telephone_number: "09213579086",
birthday: nil, sex: 0, side_effect: "特に無し", allergy: "特に無し", sick: "特に無し", operation: "特に無し", note: "特に無し", role: 0)
developer1 = User.create(name: "○田薬品の開発者", email: "developer@gmail.com", password: "password", role: 1)
developer2 = User.create(name: "大日○住友製薬の開発者", email: "developer2@gmail.com", password: "password", role: 1)
developer3 = User.create(name: "塩○義製薬の開発者", email: "developer3@gmail.com", password: "password", role: 1)
developer4 = User.create(name: "○ノフィの開発者", email: "developer4@gmail.com", password: "password", role: 1)
developer5 = User.create(name: "アステ○ス製薬の開発者", email: "developer5@gmail.com", password: "password", role: 1)
developer6 = User.create(name: "第一○共の開発者", email: "developer6@gmail.com", password: "password", role: 1)
developer7 = User.create(name: "沢○製薬", email: "developer6@gmail.com", password: "password", role: 1)
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
Medicine.create(name: "ネシーナ錠", standard: 25, unit: 0, user_id: developer1.id)
Medicine.create(name: "ロゼレム錠", standard: 8, unit: 0, user_id: developer1.id)
metgluco_500_mg = Medicine.create(name: "メトグルコ錠", standard: 500, unit: 0, permission: true, user_id: developer2.id)
Medicine.create(name: "ゾフルーザ錠", standard: 20, unit: 0, permission: true, user_id: developer3.id)
lasix_20_mg = Medicine.create(name: "ラシックス錠", standard: 20, unit: 0, permission: true, user_id: developer4.id)
myslee_5_mg = Medicine.create(name: "マイスリー錠", standard: 5, unit: 0, permission: true, user_id: developer5.id)
loxonin_60_mg = Medicine.create(name: "ロキソニン錠", standard: 60, unit: 0, permission: true, user_id: developer6.id)
Medicine.create(name: "セフカペンピボキシル塩酸塩錠", standard: 100, user_id: developer7.id)

method_1 = TakeMethodDetail.create(style: "朝食後")
TakeMethodDetail.create(style: "朝食前")
TakeMethodDetail.create(style: "朝食間")
TakeMethodDetail.create(style: "昼食後")
TakeMethodDetail.create(style: "昼食前")
TakeMethodDetail.create(style: "昼食間")
method_2 = TakeMethodDetail.create(style: "夕食後")
TakeMethodDetail.create(style: "夕食前")
TakeMethodDetail.create(style: "夕食間")
TakeMethodDetail.create(style: "起床時")
method_4 = TakeMethodDetail.create(style: "寝る前")
method_3 = TakeMethodDetail.create(style: "毎食後")
TakeMethodDetail.create(style: "毎食前")
TakeMethodDetail.create(style: "毎食間")
method_5 = TakeMethodDetail.create(style: "朝夕食後")
TakeMethodDetail.create(style: "朝夕食前")
TakeMethodDetail.create(style: "朝夕食間")
TakeMethodDetail.create(style: "朝昼食後")
TakeMethodDetail.create(style: "朝昼食前")
TakeMethodDetail.create(style: "朝昼食間")
TakeMethodDetail.create(style: "昼夕食後")
TakeMethodDetail.create(style: "昼夕食前")
TakeMethodDetail.create(style: "昼夕食間")
TakeMethodDetail.create(style: "毎食後寝る前")
TakeMethodDetail.create(style: "起床時毎食後")
TakeMethodDetail.create(style: "起床時毎食後寝る前")

record_1 = MedicineNotebookRecord.create(user_id: second_user.id, pharmacy_id: second_user.id, date_of_issue: "2020-12-18".to_date,
date_of_dispensing: "2020-12-18".to_date, medical_institution_name: "浪速大学医学部付属病院", doctor_name: "財前五郎", note: "いつもの薬")
detail_1 = PrescriptionDetail.create(medicine_notebook_record_id: record_1.id, prescription_days: 30, times: 1, daily_dose: 1, number_of_dose: "1")
MedicineRecordRelation.create(medicine_id: azilsartan_10_mg.id, prescription_detail_id: detail_1.id)
TakeMedicineRelation.create(prescription_detail_id: detail_1.id, take_method_detail_id: method_1.id)
detail_2 = PrescriptionDetail.create(medicine_notebook_record_id: record_1.id, prescription_days: 30, times: 1, daily_dose: 1, number_of_dose: "1")
MedicineRecordRelation.create(medicine_id: lansoprazole_od_15_mg.id, prescription_detail_id: detail_2.id)
TakeMedicineRelation.create(prescription_detail_id: detail_2.id, take_method_detail_id: method_2.id)
detail_3 = PrescriptionDetail.create(medicine_notebook_record_id: record_1.id, prescription_days: 30, times: 3, daily_dose: 3, number_of_dose: "1-1-1")
MedicineRecordRelation.create(medicine_id: metgluco_500_mg.id, prescription_detail_id: detail_3.id)
TakeMedicineRelation.create(prescription_detail_id: detail_3.id, take_method_detail_id: method_3.id)

record_2 = MedicineNotebookRecord.create(user_id: second_user.id, pharmacy_id: second_user.id, date_of_issue: "2021-01-18".to_date,
date_of_dispensing: "2021-01-18".to_date, medical_institution_name: "浪速大学医学部付属病院", doctor_name: "財前五郎")
detail_4 = PrescriptionDetail.create(medicine_notebook_record_id: record_2.id, prescription_days: 30, times: 1, daily_dose: 1, number_of_dose: "1")
MedicineRecordRelation.create(medicine_id: azilsartan_10_mg.id, prescription_detail_id: detail_4.id)
TakeMedicineRelation.create(prescription_detail_id: detail_4.id, take_method_detail_id: method_1.id)
detail_5 = PrescriptionDetail.create(medicine_notebook_record_id: record_2.id, prescription_days: 30, times: 1, daily_dose: 1, number_of_dose: "1")
MedicineRecordRelation.create(medicine_id: lansoprazole_od_15_mg.id, prescription_detail_id: detail_5.id)
TakeMedicineRelation.create(prescription_detail_id: detail_5.id, take_method_detail_id: method_2.id)
detail_6 = PrescriptionDetail.create(medicine_notebook_record_id: record_2.id, prescription_days: 30, times: 3, daily_dose: 3, number_of_dose: "1-1-1")
MedicineRecordRelation.create(medicine_id: metgluco_500_mg.id, prescription_detail_id: detail_6.id)
TakeMedicineRelation.create(prescription_detail_id: detail_6.id, take_method_detail_id: method_3.id)

record_3 = MedicineNotebookRecord.create(user_id: second_user.id, pharmacy_id: second_user.id, date_of_issue: "2021-02-18".to_date,
date_of_dispensing: "2021-02-18".to_date, medical_institution_name: "浪速大学医学部付属病院", doctor_name: "財前五郎", note: "薬が1種類増えました")
detail_7 = PrescriptionDetail.create(medicine_notebook_record_id: record_3.id, prescription_days: 30, times: 1, daily_dose: 1, number_of_dose: "1")
MedicineRecordRelation.create(medicine_id: azilsartan_10_mg.id, prescription_detail_id: detail_7.id)
TakeMedicineRelation.create(prescription_detail_id: detail_7.id, take_method_detail_id: method_1.id)
detail_8 = PrescriptionDetail.create(medicine_notebook_record_id: record_3.id, prescription_days: 30, times: 1, daily_dose: 1, number_of_dose: "1")
MedicineRecordRelation.create(medicine_id: lansoprazole_od_15_mg.id, prescription_detail_id: detail_8.id)
TakeMedicineRelation.create(prescription_detail_id: detail_8.id, take_method_detail_id: method_2.id)
detail_9 = PrescriptionDetail.create(medicine_notebook_record_id: record_3.id, prescription_days: 30, times: 3, daily_dose: 3, number_of_dose: "1-1-1")
MedicineRecordRelation.create(medicine_id: metgluco_500_mg.id, prescription_detail_id: detail_9.id)
TakeMedicineRelation.create(prescription_detail_id: detail_9.id, take_method_detail_id: method_3.id)
detail_10 = PrescriptionDetail.create(medicine_notebook_record_id: record_3.id, prescription_days: 30, times: 1, daily_dose: 0.5, number_of_dose: "0.5")
MedicineRecordRelation.create(medicine_id: lasix_20_mg.id, prescription_detail_id: detail_10.id)
TakeMedicineRelation.create(prescription_detail_id: detail_10.id, take_method_detail_id: method_1.id)

record_4 = MedicineNotebookRecord.create(user_id: second_user.id, pharmacy_id: second_user.id, date_of_issue: "2021-01-30".to_date,
date_of_dispensing: "2021-01-30".to_date, medical_institution_name: "帝都大学医学部付属病院", doctor_name: "湯川学", note: "必要時に服用中")
detail_11 = PrescriptionDetail.create(medicine_notebook_record_id: record_4.id, prescription_days: 14, times: 1, daily_dose: 1, number_of_dose: "1")
MedicineRecordRelation.create(medicine_id: myslee_5_mg.id, prescription_detail_id: detail_11.id)
TakeMedicineRelation.create(prescription_detail_id: detail_11.id, take_method_detail_id: method_4.id)
detail_12= PrescriptionDetail.create(medicine_notebook_record_id: record_4.id, prescription_days: 14, times: 2, daily_dose: 2, number_of_dose: "1-1")
MedicineRecordRelation.create(medicine_id: loxonin_60_mg.id, prescription_detail_id: detail_12.id)
TakeMedicineRelation.create(prescription_detail_id: detail_12.id, take_method_detail_id: method_5.id)
