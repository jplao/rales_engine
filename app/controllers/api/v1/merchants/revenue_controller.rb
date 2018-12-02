class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantRevenueSerializer.new(Merchant.total_revenue(params[:quantity]))
  end

  def show
    render json: MerchantRevenueSerializer.new(Merchant.revenue(params[:id]).first)
  end
end
