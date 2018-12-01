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
end
