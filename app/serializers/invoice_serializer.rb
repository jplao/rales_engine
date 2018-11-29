class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :status, :created_at, :updated_at
  belongs_to :customer
  belongs_to :merchant
end
