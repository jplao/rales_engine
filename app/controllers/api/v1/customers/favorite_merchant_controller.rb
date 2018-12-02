class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.favorite_merchant(params[:id]).first)
  end
end
