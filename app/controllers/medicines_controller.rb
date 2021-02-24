class MedicinesController < ApplicationController
  before_action :not_pharmacy
  before_action :developer_privileges
  before_action :master_privileges, only: %i[update destroy]
  before_action :set_medicine, only: %i[show update destroy]

  def index
    @medicines = Medicine.authority_category(current_user)
  end

  def new
    @medicine = Medicine.new
  end

  def create
    @medicine = Medicine.new(medicine_params)
    @medicine.user_id = current_user.id
    if @medicine.save
      flash[:notice] = I18n.t('message.medicine.create_success')
      redirect_to medicines_path
    else
      flash[:notice] = I18n.t('message.medicine.create_failure')
      render :new
    end
  end

  def show
  end

  def update
    @medicine.update(permission: "permit")
    flash[:notice] = I18n.t('message.medicine.update_success')
    redirect_to @medicine
  end

  def destroy
    medicine_name = @medicine.name
    @medicine.destroy
    flash[:notice] = I18n.t('message.medicine.destroy_success', medicine_name: medicine_name )
    redirect_to medicines_path
  end

  private

  def not_pharmacy
    if pharmacy_signed_in?
      flash[:alert] = I18n.t('message.medicine.special_authority')
      redirect_to root_path
    end
  end

  def developer_privileges
    unless current_user.role == "master" || current_user.role == "developer"
      flash[:alert] = I18n.t('message.medicine.special_authority')
      redirect_to root_path
    end
  end

  def master_privileges
    if current_user.role != "master"
      flash[:alert] = I18n.t('message.medicine.only_admin')
      redirect_to root_path
    end
  end

  def set_medicine
    @medicine = Medicine.find(params[:id])
  end

  def medicine_params
    params.require(:medicine).permit(:name, :standard, :unit, :permission)
  end
end
