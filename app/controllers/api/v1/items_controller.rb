class Api::V1::ItemsController < ApplicationController

  def index
    if params[:merchant_id]
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
    elsif params[:invoice_id]
      render json: ItemSerializer.new(Invoice.find(params[:invoice_id]).items)
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

  def show
    if params[:invoice_item_id]
      render json: ItemSerializer.new(InvoiceItem.find(params[:invoice_item_id]).item)
    else
      render json: ItemSerializer.new(Item.find(params[:id]))
    end
  end
end
