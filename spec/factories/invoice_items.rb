FactoryBot.define do
  factory :invoice_item do
    item { create(:item) }
    invoice { create(:invoice) }
    quantity { Faker::Number.within(range: 1..10) }
    unit_price { Faker::Commerce.price }
  end
end