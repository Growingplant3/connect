class TakeMethodDetailsController < ApplicationController
  def index
  end
  
  def new
    @take_method_detail = TakeMethodDetail.new
  end
end
