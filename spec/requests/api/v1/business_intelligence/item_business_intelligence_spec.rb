require 'rails_helper'

describe 'Item API' do
  it 'sends a variable number of items that generate the most revenue' do
    item_1, item_2, item_3 = create_list(:item, 3)
    item_4 = create(:item)
    invoice_1, invoice_2 = create_list(:invoice, 2)
    ii_1 = create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 2, unit_price: 100)
    ii_2 = create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 2, unit_price: 200)
    ii_3 = create(:invoice_item, invoice: invoice_2, item: item_4, quantity: 1, unit_price: 300)
    ii_4 = create(:invoice_item, invoice: invoice_2, item: item_3, quantity: 1, unit_price: 100)

    get "/api/v1/items/most_revenue?quantity=3"

    items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(items.count).to eq(3)
    expect(items[0]['attributes']['id']).to eq(item_2.id)
    expect(items[1]['attributes']['id']).to eq(item_4.id)
    expect(items[2]['attributes']['id']).to eq(item_1.id)
  end

end
