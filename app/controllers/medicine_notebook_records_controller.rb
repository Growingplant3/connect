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
      flash[:notice] = "処方記録を作成しました"
      redirect_to user_medicine_notebook_records_path(params[:user_id])
    else
      flash.now[:notice] = "処方記録を作成できません"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @medicine_notebook_record.update(medicine_notebook_record_params)
      flash[:notice] = "処方記録を更新しました"
      redirect_to @medicine_notebook_record
    else
      flash.now[:notice] = "処方記録を更新できません"
      render :edit
    end
  end

  def destroy
    @medicine_notebook_record.destroy
    flash[:alert] = "処方記録を削除しました"
    redirect_to user_medicine_notebook_records_path(params[:user_id])
  end

  private

  def medicine_notebook_record_params
    params.require(:medicine_notebook_record).permit(:user_id, :pharmacy_id, :date_of_issue, :date_of_dispensing, :medical_institution_name, :doctor_name, :note)
  end

  def set_medicine_notebook_record
    @medicine_notebook_record = MedicineNotebookRecord.find(params[:medicine_notebook_record_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
