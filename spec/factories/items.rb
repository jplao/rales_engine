FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "NameOfItem#{n}" }
    description { "Description of each item." }
    unit_price {1}
    merchant
  end
end
