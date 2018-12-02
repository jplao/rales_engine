class Api::V1::Merchants::DateRevenueController < ApplicationController
  def show
    render json: MerchantTotalRevenueSerializer.new(Invoice.total_revenue_by_date(params[:date])[0])
  end
end
