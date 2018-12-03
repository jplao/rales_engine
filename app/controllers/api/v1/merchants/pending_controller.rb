class Api::V1::Merchants::PendingController < ApplicationController

  def index
    render json: CustomerSerializer.new(Customer.with_pending_invoices(params[:id]))
  end
end
