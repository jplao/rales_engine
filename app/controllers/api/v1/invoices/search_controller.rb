class Api::V1::Invoices::SearchController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Invoice.where(search_params))
  end

  def show
    if search_params.empty?
      render json: InvoiceSerializer.new(Invoice.find_random)
    else
      render json: InvoiceSerializer.new(Invoice.find_by(search_params))
    end
  end
end

private
def search_params
  params.permit(:id, :created_at, :updated_at)
end
