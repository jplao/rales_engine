require 'rails_helper'

describe 'nested invoice resources API' do
  it 'sends transactions specific to a invoice' do
    invoice = create(:invoice)
    transaction_1, transaction_2 = create_list(:transaction, 2, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)
    expect(transactions["data"].count).to eq(2)
  end

  it 'sends invoice items specific to a invoice' do
    invoice = create(:invoice)
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"].count).to eq(2)
  end
end
