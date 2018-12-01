require 'rails_helper'

describe 'nested invoice resources API' do
  it 'sends transactions specific to a invoice' do
    merchant_1 = create(:merchant)
    item_1, item_2 = create(:item, merchant: merchant_1)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant_1)
    transaction_1, transaction_2 = create_list(:transaction, 2, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(2)
  end

end
