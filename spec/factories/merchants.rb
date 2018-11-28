FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "MerchantName#{n}" }
  end
end
