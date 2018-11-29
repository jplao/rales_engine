class Api::V1::Customers::SearchController < ApplicationController

  def index
    render json: CustomerSerializer.new(Customer.where(search_params))
  end

  def show
    if search_params.empty?
      render json: CustomerSerializer.new(Customer.find_random)
    else
      render json: CustomerSerializer.new(Customer.find_by(search_params))
    end
  end
end

private
def search_params
  params.permit(:id, :first_name, :created_at, :updated_at)
end
