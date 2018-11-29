class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :created_at, :updated_at, :description, :unit_price
  belongs_to :merchant
end
