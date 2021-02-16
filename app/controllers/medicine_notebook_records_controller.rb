class MedicineNotebookRecordsController < ApplicationController
  before_action :set_medicine_notebook_record, only: %i[show edit update destroy]
  before_action :set_user
  before_action :current_user_or_pharmacies
  before_action :reference_only, except: %i[index show]

  def index
    @medicine_notebook_records = @user.medicine_notebook_records.descending_order
  end

  def new
    @medicine_notebook_record = @user.medicine_notebook_records.build
    @prescription_detail = @medicine_notebook_record.prescription_details.build
  end

  def create
    @medicine_notebook_record = @user.medicine_notebook_records.build(medicine_notebook_record_params)
    @medicine_notebook_record.pharmacy_id = current_pharmacy.id
    if @medicine_notebook_record.save
      flash[:notice] = I18n.t('message.medicine_notebook_record.create_success')
      redirect_to user_medicine_notebook_records_path(@user)
    else
      flash.now[:notice] = I18n.t('message.medicine_notebook_record.create_failure')
      # 保留
      render new_user_medicine_notebook_record_path(@user)
    end
  end

  def show
  end

  def edit
  end

  def update
    if @medicine_notebook_record.update(medicine_notebook_record_params)
      flash[:notice] = I18n.t('message.medicine_notebook_record.update_success')
      redirect_to user_medicine_notebook_record_path(@user)
    else
      flash.now[:notice] = I18n.t('message.medicine_notebook_record.update_failure')
      # 保留
      render edit_medicine_notebook_record_path(@user, @medicine_notebook_record)
    end
  end

  def destroy
    @medicine_notebook_record.destroy
    flash[:alert] = I18n.t('message.medicine_notebook_record.destroy_success')
    redirect_to user_medicine_notebook_records_path(@user)
  end

  private

  def medicine_notebook_record_params
    params.require(:medicine_notebook_record).permit(:date_of_issue, :date_of_dispensing, :medical_institution_name, :doctor_name, :note,
      prescription_details_attributes: [:id, :prescription_days, :times, :daily_dose, :number_of_dose, :_destroy])
  end

  def set_medicine_notebook_record
    @medicine_notebook_record = MedicineNotebookRecord.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def current_user_or_pharmacies
    unless @user == current_user || pharmacy_signed_in?
      flash[:alert] = I18n.t('flash.alert.user.only_myself')
      redirect_to root_path
    end
  end

  def reference_only
    unless pharmacy_signed_in?
      flash[:alert] = I18n.t('flash.alert.user.reference_only')
      redirect_to root_path
    end
  end
end
