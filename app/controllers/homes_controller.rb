class HomesController < ApplicationController
  def index
  end

  def sample_user_first
    unless user = User.find_by_email("kikukawa@gmail.com")
      random_words = SecureRandom.urlsafe_base64
      sample_name = "sample_user"
      random_email = "#{random_words}@gmail.com"
      random_password = random_words
      user = User.create(name: sample_name, email: random_email, password: random_password)
    end
    sign_in user
    flash[:notice] = I18n.t('message.sample_user_login')
    redirect_to user
  end

  def sample_user_second
    unless user = User.find_by_email("nogiku@gmail.com")
      random_words = SecureRandom.urlsafe_base64
      sample_name = "sample_user"
      random_email = "#{random_words}@gmail.com"
      random_password = random_words
      user = User.create(name: sample_name, email: random_email, password: random_password)
    end
    sign_in user
    flash[:notice] = I18n.t('message.sample_user_login')
    redirect_to user
  end

  def sample_pharmacy
    unless pharmacy = Pharmacy.find_by_email("himawari@gmail.com")
      random_words = SecureRandom.urlsafe_base64
      sample_name = "sample_pharmacy"
      random_email = "#{random_words}@gmail.com"
      random_password = random_words
      pharmacy = Pharmacy.create(name: sample_name, email: random_email, password: random_password)
      7.times do |index|
        pharmacy.activities.create(day_of_the_week: index)
      end
    end
    sign_in pharmacy
    flash[:notice] = I18n.t('message.sample_pharmacy_login')
    redirect_to pharmacy
  end

  def developer
    developer = User.find_by_email("developer@gmail.com")
    flash[:notice] = I18n.t('message.developer_login')
    sign_in developer
    redirect_to medicines_path
  end

  def admin
    admin = User.find_by_email("admin@gmail.com")
    flash[:notice] = I18n.t('message.admin_login')
    sign_in admin
    redirect_to medicines_path
  end
end
