class Api::V1::Transactions::SearchController < ApplicationController

  def index
    render json: TransactionSerializer.new(Transaction.where(search_params))
  end

  def show
    if search_params.empty?
      render json: TransactionSerializer.new(Transaction.find_random)
    else
      render json: TransactionSerializer.new(Transaction.find_by(search_params))
    end
  end
end

private
def search_params
  params.permit(:id, :created_at, :updated_at)
end
