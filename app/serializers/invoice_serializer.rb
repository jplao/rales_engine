class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :customer_id, :id, :merchant_id, :status
end
