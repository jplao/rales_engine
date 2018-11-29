class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]).revenue)
  end
end
