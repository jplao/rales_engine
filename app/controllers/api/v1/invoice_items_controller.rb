class Api::V1::InvoiceItemsController < ApplicationController

  def index
    if params[:invoice_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_id: params[:invoice_id]))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.all)
    end
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]))
  end
end
