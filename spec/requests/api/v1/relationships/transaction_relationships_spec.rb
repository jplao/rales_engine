require 'rails_helper'

describe 'nested transaction resources API' do
  it 'sends invoice specific to a transaction' do
    invoice_1 = create(:invoice)
    transaction = create(:transaction, invoice: invoice_1)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)
    expect(invoice["data"]['attributes']['id']).to eq(invoice_1.id)
  end
end
