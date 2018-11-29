class Api::V1::Merchants::ItemController < ApplicationController
  def index
    render json: Merchant.most_items(params[:quantity])
  end
end
