class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantRevenueSerializer.new(Merchant.total_revenue(params[:quantity]))
  end

  def show
    if params[:date]
      render json: MerchantRevenueSerializer.new(Invoice.merchant_revenue_by_date(params[:date], params[:id])[0])
    else
      render json: MerchantRevenueSerializer.new(Merchant.revenue(params[:id]).first)
    end
  end
end
