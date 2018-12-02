class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :revenue do |object|
    (object.revenue / 100.00).to_s
  end
end
