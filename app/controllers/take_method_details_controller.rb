class TakeMethodDetailsController < ApplicationController
  def index
    @take_method_details = TakeMethodDetail.all
  end
  
  def new
    @take_method_detail = TakeMethodDetail.new
  end
  
  def create
    @take_method_detail = TakeMethodDetail.new(take_method_detail_params)
    if @take_method_detail.save
      flash[:notice] = I18n.t('message.take_method_detail.create_success')
      redirect_to take_method_details_path
    else
      flash.now[:notice] = I18n.t('message.take_method_detail.create_failure')
      render :new
    end
  end

  def destroy
    @take_method_detail = TakeMethodDetail(params[:id])
    @take_method_detail.destroy
    flash[:notice] = I18n.t('message.take_method_detail.destroy_failure')
    redirect_to take_method_details_path
  end

  private

  def take_method_detail_params
    params.require(:take_method_detail).permit(:style)
  end
end
