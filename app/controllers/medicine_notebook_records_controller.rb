class MedicineNotebookRecordsController < ApplicationController
  before_action :set_medicine_notebook_record, only: %i[show edit update destroy]
  before_action :set_user

  def index
    @medicine_notebook_records = @user.medicine_notebook_records.order(date_of_issue: "desc")
  end

  def new
    @medicine_notebook_record = @user.medicine_notebook_records.build
  end

  def create
    @medicine_notebook_record = @user.medicine_notebook_records.build(medicine_notebook_record_params)
    @medicine_notebook_record.pharmacy_id = current_pharmacy.id
    if @medicine_notebook_record.save
      flash[:notice] = I18n.t('message.medicine_notebook_record.create_success')
      redirect_to user_medicine_notebook_records_path(@user)
    else
      flash.now[:notice] = I18n.t('message.medicine_notebook_record.create_failure')
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @medicine_notebook_record.update(medicine_notebook_record_params)
      flash[:notice] = I18n.t('message.medicine_notebook_record.update_success')
      redirect_to @medicine_notebook_record
    else
      flash.now[:notice] = I18n.t('message.medicine_notebook_record.update_failure')
      render :edit
    end
  end

  def destroy
    @medicine_notebook_record.destroy
    flash[:alert] = I18n.t('message.medicine_notebook_record.destroy_success')
    redirect_to user_medicine_notebook_records_path(@user)
  end

  private

  def medicine_notebook_record_params
    params.require(:medicine_notebook_record).permit(:user_id, :pharmacy_id, :date_of_issue, :date_of_dispensing, :medical_institution_name, :doctor_name, :note)
  end

  def set_medicine_notebook_record
    @medicine_notebook_record = MedicineNotebookRecord.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
