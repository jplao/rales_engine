class Api::V1::Merchants::ItemController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_items(params[:quantity]))
  end
end
