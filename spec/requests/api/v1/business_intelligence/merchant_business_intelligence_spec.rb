require 'rails_helper'

describe 'Merchant API' do
  it 'calculates revenue for each merchant' do
    merch = create(:merchant)
    item_1, item_2 = create_list(:item, 2, merchant: merch)
    invoice = create(:invoice, merchant: merch)
    invoice_item = create(:invoice_item, item: item_1, quantity: 2, invoice: invoice)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/merchants/#{merch.id}/revenue"

    revenue = JSON.parse(response.body)['data']
    expect(response).to be_successful
    expect(revenue).to eq(2)
  end
end
