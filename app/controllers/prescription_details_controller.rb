class PrescriptionDetailsController < ApplicationController
  before_action :set_prescription_detail, only: %i[edit update destroy]
  before_action :set_medicine_notebook_record
  before_action :set_user

  def new
    @prescription_detail = PrescriptionDetail.new
    @prescription_detail.medicine_record_relations.build
  end

  def create
    @prescription_detail = @medicine_notebook_record.prescription_details.build(prescription_detail_params)
    if @prescription_detail.save
      flash[:notice] = I18n.t('message.prescription_detail.create_success')
      redirect_to user_medicine_notebook_record_path(@user, @medicine_notebook_record)
    else
      flash.now[:notice] = I18n.t('message.prescription_detail.create_failure')
      render :new
    end
  end

  def edit
  end

  def update
    if @prescription_detail.update(prescription_detail_params)
      flash[:notice] = I18n.t('message.prescription_detail.update_success')
      redirect_to user_medicine_notebook_record_path(@user, @medicine_notebook_record)
    else
      flash[:notice] = I18n.t('message.prescription_detail.update_failure')
      render :edit
    end
  end

  def destroy
    @prescription_detail.destroy
    flash[:notice] = I18n.t('message.prescription_detail.destroy_success')
    redirect_to user_medicine_notebook_record_path(@user, @medicine_notebook_record)
  end

  private

  def prescription_detail_params
    params.require(:prescription_detail).permit(:prescription_days, :times, :daily_dose, :number_of_dose,
      medicine_record_relations_attributes: [:id, :medicine_id, :_destroy])
  end

  def set_prescription_detail
    @prescription_detail = PrescriptionDetail.find(params[:id])
  end

  def set_medicine_notebook_record
    @medicine_notebook_record = MedicineNotebookRecord.find(params[:medicine_notebook_record_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
