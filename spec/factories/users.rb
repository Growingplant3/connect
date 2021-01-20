FactoryBot.define do
	factory :new_user, class: User do
		name { "新規登録ユーザー" }
		email { "new_user@gmail.com" }
		password { "new_user" }
		password_confirmation { "new_user" }
	end

  factory :user do
		name { "一般ユーザー" }
		postcode { "1050011" }
		address { "東京都港区芝公園4丁目2-8" }
		telephone_number { "0311112222" }
		birthday { "2000/01/01".to_datetime }
		sex { "unknown" }
		side_effect { "マイスリーで眠気" }
		allergy { "小麦" }
		sick { "胃潰瘍" }
		operation { "骨折の手術" }
		note { "日中は仕事のため、電話に出られません。" }
		role { "normal" }
		email { "user@gmail.com" }
		password { "password" }
		password_confirmation { "password" }
  end
end
