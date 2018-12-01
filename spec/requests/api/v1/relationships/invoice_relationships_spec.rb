require 'rails_helper'

describe 'nested invoice resources API' do
  it 'sends transactions specific to an invoice' do
    invoice = create(:invoice)
    transaction_1, transaction_2 = create_list(:transaction, 2, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)
    expect(transactions["data"].count).to eq(2)
  end

  it 'sends invoice items specific to an invoice' do
    invoice = create(:invoice)
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"].count).to eq(2)
  end

  it 'sends items specific to an invoice' do
    invoice = create(:invoice)
    item_1, item_2 = create_list(:item, 2)
    invoice_item_1 = create(:invoice_item, invoice: invoice, item: item_1)
    invoice_item_2 = create(:invoice_item, invoice: invoice, item: item_2)


    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(2)
  end

  it 'sends the customer specific to an invoice' do
    customer_1 = create(:customer)
    invoice = create(:invoice, customer: customer_1)

    get "/api/v1/invoices/#{invoice.id}/customer"

    expect(response).to be_successful

    customer = JSON.parse(response.body)
    expect(customer["data"][0]['id']).to eq(customer_1.id.to_s)
  end

  it 'sends the merchant specific to an invoice' do
    merchant_1 = create(:merchant)
    invoice = create(:invoice, merchant: merchant_1)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)
    expect(merchant["data"][0]['id']).to eq(merchant_1.id.to_s)
  end
end
