class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.total_revenue(params[:quantity])
  end

  def show
    render json: Merchant.revenue(params[:id])
  end
end
