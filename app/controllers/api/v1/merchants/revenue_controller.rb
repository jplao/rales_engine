class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.total_revenue(params[:quantity]))
  end

  def show
    render json: MerchantSerializer.new(Merchant.revenue(params[:id]))
  end
end
