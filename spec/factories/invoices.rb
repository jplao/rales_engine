FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { "successful" }
  end
end
