require 'rails_helper'

describe 'nested invoice items resources API' do
  it 'sends invoice specific to an invoice item' do
    invoice_1 = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice_1)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)
    expect(invoice["data"]['attributes']['id']).to eq(invoice_1.id)
  end

  it 'sends invoice specific to an invoice item' do
    item_1 = create(:item)
    invoice_item = create(:invoice_item, item: item_1)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(response).to be_successful

    item = JSON.parse(response.body)
    expect(item["data"]['attributes']['id']).to eq(item_1.id)
  end
end
