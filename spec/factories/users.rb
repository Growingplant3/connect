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
		birthday { "2000-01-01".to_date }
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
	
	factory :first_user, class: User do
		name { "菊川" }
		email { "kikukawa@gmail.com" }
		password { "password" }
		address { "福岡県福岡市" }
		telephone_number { "09212345678" }
		birthday { "1995-04-02".to_date }
		sex { 1 }
		role { 0 }
	end

	factory :second_user, class: User do
		name { "野菊" }
		email { "nogiku@gmail.com" }
		password { "password" }
		address { "福岡県北九州市" }
		telephone_number { "09213572468" }
		birthday { "1995-08-02".to_date }
		sex { 2 }
		role { 0 }
	end

	factory :third_user, class: User do
		name { "菊池" }
		email { "kikuchi@gmail.com" }
		password { "password" }
		address { "福岡県久留米市" }
		telephone_number { "09287654321" }
		birthday { "1965-01-02".to_date }
		sex { 1 }
		role { 0 }
	end

	factory :fourth_user, class: User do
		name { "菊川" }
		email { "kikukiku@gmail.com" }
		password { "password" }
		postcode { "8100031" }
		address { "福岡県筑後市" }
		telephone_number { "09213579086" }
		birthday { nil }
		sex { 0 }
		role { 0 }
	end

	factory :developer, class: User do
		name { "開発者" }
		email { "developer@gmail.com" }
		password { "password" }
		role { 1 }
	end

	factory :admin, class: User do
		name { "管理者" }
		email { "admin@gmail.com" }
		password { "password" }
		role { 2 }
	end
end
