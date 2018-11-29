FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { "pending" }
  end
end
