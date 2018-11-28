FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "NameOfItem#{n}" }
    description { "Description of each item." }
    merchant
  end
end
