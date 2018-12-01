class Api::V1::InvoiceItems::SearchController < ApplicationController

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(search_params))
  end

  def show
    if search_params.empty?
      render json: InvoiceItemSerializer.new(InvoiceItem.find_random)
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(search_params))
    end
  end
end

private
def search_params
  params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
end
