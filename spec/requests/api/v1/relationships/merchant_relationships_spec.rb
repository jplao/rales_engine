require 'rails_helper'

describe 'nested merchant resources API' do
  it 'sends items specific to a merchant' do
    merchant_1, merchant_2 = create_list(:merchant, 2)
    item_1, item_2 = create_list(:item, 2, merchant: merchant_1)
    item_3 = create(:item, merchant: merchant_2)

    get "/api/v1/merchants/#{merchant_1.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(2)
  end

  it 'sends invoices specific to a merchant' do
    merchant_1, merchant_2 = create_list(:merchant, 2)
    invoice_1, invoice_2 = create_list(:invoice, 2, merchant: merchant_1)
    invoice_3 = create(:invoice, merchant: merchant_2)

    get "/api/v1/merchants/#{merchant_1.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)
    expect(invoices["data"].count).to eq(2)
  end
end
