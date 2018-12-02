require 'rails_helper'

describe 'Customer API' do
  it 'sends a favorite merchant for a specific customer' do
    merchant_1, merchant_2 = create_list(:merchant, 2)
    customer_1 = create(:customer)
    invoice_1 = create(:invoice, customer: customer_1, merchant: merchant_1)
    invoice_2, invoice_3 = create_list(:invoice, 2, customer: customer_1, merchant: merchant_2)
    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)

    get "/api/v1/customers/#{customer_1.id}/favorite_merchant"

    merchant = JSON.parse(response.body)['data']
    expect(response).to be_successful
    expect(merchant['attributes']['id']).to eq(merchant_2.id)
  end
end
