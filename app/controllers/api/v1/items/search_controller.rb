class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.where(search_params))
  end

  def show
    if search_params.empty?
      render json: ItemSerializer.new(Item.find_random)
    else
      render json: ItemSerializer.new(Item.find_by(search_params))
    end
  end
end

private
def search_params
  params.permit(:id, :name, :created_at, :updated_at)
end
