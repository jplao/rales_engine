FactoryBot.define do
  factory :item do
    name { "NameOfItem" }
    description { "Description of each item." }
    merchant
  end
end
