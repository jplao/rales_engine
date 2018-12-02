require 'rails_helper'

describe 'Merchant API' do
  it 'calculates revenue for each merchant' do
    merch = create(:merchant)
    item_1, item_2 = create_list(:item, 2, merchant: merch)
    invoice = create(:invoice, merchant: merch)
    invoice_item = create(:invoice_item, item: item_1, quantity: 2, unit_price: 200, invoice: invoice)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/merchants/#{merch.id}/revenue"

    revenue = JSON.parse(response.body)['data']

    expect(response).to be_successful
  
    expect(revenue['attributes']['revenue']).to eq(4.00)
  end

  it 'sends favorite customer specific to a merchant' do
    merchant_1, merchant_2 = create_list(:merchant, 2)
    customer_1, customer_2 = create_list(:customer, 2)
    invoice_1 = create(:invoice, merchant: merchant_1, customer: customer_2)
    transaction_1, transaction_2 = create_list(:transaction, 2, invoice: invoice_1)
    invoice_2 = create(:invoice, merchant: merchant_1, customer: customer_1)
    transaction_3 = create(:transaction, invoice: invoice_2)
    invoice_3 = create(:invoice, merchant: merchant_2, customer: customer_1)
    transaction_4, transaction_5 = create_list(:transaction, 2, invoice: invoice_3)

    get "/api/v1/merchants/#{merchant_1.id}/favorite_customer"

    customer = JSON.parse(response.body)['data']
    expect(response).to be_successful
    expect(customer['attributes']['id']).to eq(customer_2.id)
    expect(customer['attributes']['id']).to_not eq(customer_1.id)
  end

end
