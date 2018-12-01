require 'rails_helper'

describe 'nested customer resources API' do
  it 'sends invoices specific to a customer' do
    customer_1, customer_2 = create_list(:customer, 2)
    invoice_1, invoice_2 = create_list(:invoice, 2, customer: customer_1)
    invoice_3 = create(:invoice, customer: customer_2)

    get "/api/v1/customers/#{customer_1.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]['attributes']['customer_id']).to eq(customer_1.id)
    expect(invoices["data"][1]['attributes']['customer_id']).to eq(customer_1.id)
    expect(invoices["data"][0]['attributes']['customer_id']).to_not eq(customer_2.id)
  end

  it 'sends trasactions specific to a customer' do
    customer_1, customer_2 = create_list(:customer, 2)
    invoice_1, invoice_2 = create_list(:invoice, 2, customer: customer_1)
    invoice_3 = create(:invoice, customer: customer_2)
    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_1)
    transaction_3 = create(:transaction, invoice: invoice_2)
    transaction_4 = create(:transaction, invoice: invoice_3)


    get "/api/v1/customers/#{customer_1.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(3)
  end
end
