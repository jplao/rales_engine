require 'rails_helper'

describe 'Merchant API' do
  it 'sends a variable number of merchants that had the most revenue' do
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)
    item_3 = create(:item, merchant: merchant_3)
    invoice_1 = create(:invoice, merchant: merchant_1)
    invoice_2 = create(:invoice, merchant: merchant_2)
    invoice_3 = create(:invoice, merchant: merchant_3)
    ii_1 = create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 101, quantity: 1)
    ii_2 = create(:invoice_item, invoice: invoice_2, item: item_2, unit_price: 200, quantity: 2)
    ii_3 = create(:invoice_item, invoice: invoice_3, item: item_3, unit_price: 300, quantity: 3)
    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)

    get "/api/v1/merchants/most_revenue?quantity=2"

    merchants = JSON.parse(response.body)['data']
    
    expect(response).to be_successful
    expect(merchants.count).to eq(2)
    expect(merchants[0]['attributes']['id']).to eq(merchant_3.id)
    expect(merchants[1]['attributes']['id']).to eq(merchant_2.id)
  end

  it 'sends the total revenue for a queried date across all merchants' do
    date = "2012-03-16"
    merchant_1, merchant_2 = create_list(:merchant, 2)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)
    invoice_1 = create(:invoice, merchant: merchant_1, created_at: date)
    invoice_2 = create(:invoice, merchant: merchant_2, created_at: date)
    invoice_3 = create(:invoice, merchant: merchant_1)
    ii_1 = create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 101, quantity: 1)
    ii_2 = create(:invoice_item, invoice: invoice_2, item: item_2, unit_price: 200, quantity: 2)
    ii_3 = create(:invoice_item, invoice: invoice_3, item: item_1, unit_price: 300, quantity: 3)
    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)

    get "/api/v1/merchants/revenue?date=#{date}"

    total_revenue = JSON.parse(response.body)['data']

    expect(response).to be_successful

    expect(total_revenue['attributes']['total_revenue']).to eq('5.01')
  end

  it 'sends total revenue for specific merchant' do
    merch = create(:merchant)
    item_1, item_2 = create_list(:item, 2, merchant: merch)
    invoice = create(:invoice, merchant: merch)
    invoice_item = create(:invoice_item, item: item_1, quantity: 2, unit_price: 201, invoice: invoice)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/merchants/#{merch.id}/revenue"

    revenue = JSON.parse(response.body)['data']

    expect(response).to be_successful

    expect(revenue['attributes']['revenue']).to eq("4.02")
  end

  it 'sends the revenue for specific merchant by a queried date' do
    date = "2012-03-16"
    merchant_1, merchant_2 = create_list(:merchant, 2)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)
    invoice_1 = create(:invoice, merchant: merchant_1, created_at: date)
    invoice_2 = create(:invoice, merchant: merchant_2, created_at: date)
    invoice_3 = create(:invoice, merchant: merchant_1)
    ii_1 = create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 101, quantity: 1)
    ii_2 = create(:invoice_item, invoice: invoice_2, item: item_2, unit_price: 200, quantity: 2)
    ii_3 = create(:invoice_item, invoice: invoice_3, item: item_1, unit_price: 300, quantity: 3)
    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)

    get "/api/v1/merchants/#{merchant_1.id}/revenue?date=#{date}"

    total_revenue = JSON.parse(response.body)['data']

    expect(response).to be_successful

    expect(total_revenue['attributes']['revenue']).to eq('1.01')
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
