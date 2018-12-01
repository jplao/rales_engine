class Api::V1::CustomersController < ApplicationController

  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    if params[:invoice_id]
      render json: CustomerSerializer.new(Customer.by_invoice(params[:invoice_id]))
    else
      render json: CustomerSerializer.new(Customer.find(params[:id]))
    end
  end
end
