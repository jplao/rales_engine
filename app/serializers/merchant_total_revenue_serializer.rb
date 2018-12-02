class MerchantTotalRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attribute :total_revenue do |object|
    (object.revenue / 100.00).to_s
  end
end
