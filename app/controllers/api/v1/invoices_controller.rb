class Api::V1::InvoicesController < ApplicationController

  def index
    if params[:merchant_id]
      render json: InvoiceSerializer.new(Invoice.where(merchant_id: params[:merchant_id]))
    else
      render json: InvoiceSerializer.new(Invoice.all)
    end
  end

  def show
    if params[:invoice_item_id]
      render json: InvoiceSerializer.new(InvoiceItem.find(params[:invoice_item_id]).invoice)
    else
      render json: InvoiceSerializer.new(Invoice.find(params[:id]))
    end
  end
end
