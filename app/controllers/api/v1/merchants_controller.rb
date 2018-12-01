class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if params[:invoice_id]
      render json: MerchantSerializer.new(Invoice.find(params[:invoice_id]).merchant)
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end
end
