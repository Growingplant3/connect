class MedicinesController < ApplicationController
  before_action :developer_privileges
  # before_action :master_privileges
  before_action :set_medicine, only: %i[edit update destroy]

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

  private

  def developer_privileges
    unless current_user.role == "master" || current_user.role == "developer"
      flash[:alert] = I18n.t('message.medicine.special_authority')
      redirect_to root_path
    end
  end

  def master_privileges
    unless current_user.role == "master"
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
