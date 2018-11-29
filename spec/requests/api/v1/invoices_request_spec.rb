require 'rails_helper'

describe 'Invoice API' do
  it 'sends a list of invoices' do
    create_list(:invoice, 3)

    get '/api/v1/invoices'
    invoices = JSON.parse(response.body)['data']
    expect(response).to be_successful
    expect(invoices.count).to eq(3)
  end

  it 'sends a single invoice' do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(invoice["id"]).to eq(id)
  end

  it 'finds a single invoice by id' do
    invoice_1 = create(:invoice).id
    invoice_2 = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice_1}"

    invoice = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(invoice["id"]).to eq(invoice_1)
    expect(invoice["id"]).to_not eq(invoice_2.id)
  end

  it 'finds a single invoice by created_at' do
    invoice_1 = create(:invoice, created_at: "2012-03-27T14:53:58.000Z")
    invoice_2 = create(:invoice)

    get "/api/v1/invoices/find?created_at=#{invoice_1.created_at}"

    invoice = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice["created_at"]).to eq("2012-03-27T14:53:58.000Z")
    expect(invoice["created_at"]).to_not eq(invoice_2.created_at)
  end

  it 'finds a single invoice by updated_at' do
    invoice_1 = create(:invoice, updated_at: "2012-03-27T14:53:58.000Z")
    invoice_2 = create(:invoice)

    get "/api/v1/invoices/find?updated_at=#{invoice_1.updated_at}"

    invoice = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice["updated_at"]).to eq("2012-03-27T14:53:58.000Z")
    expect(invoice["updated_at"]).to_not eq(invoice_2.updated_at)
  end

  it 'finds all invoices by id' do
    invoice_1 = create(:invoice).id
    invoice_2 = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice_1}"

    invoice = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(invoice["id"]).to eq(invoice_1)
    expect(invoice["id"]).to_not eq(invoice_2.id)
  end

  it 'finds all invoices by created_at' do
    created = "2012-03-27T14:53:58.000Z"
    invoice_1, invoice_2 = create_list(:invoice, 2, created_at: "2012-03-27T14:53:58.000Z")
    invoice_3 = create(:invoice)

    get "/api/v1/invoices/find_all?created_at=#{created}"

    invoices = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(invoices[0]['attributes']["created_at"]).to eq(created)
    expect(invoices[1]['attributes']["created_at"]).to eq(created)
    expect(invoices[0]['attributes']["created_at"]).to_not eq(invoice_3.created_at)
  end

  it 'finds all invoices by updated_at' do
    updated = "2012-03-27T14:53:58.000Z"
    invoice_1, invoice_2 = create_list(:invoice, 2, updated_at: "2012-03-27T14:53:58.000Z")
    invoice_3 = create(:invoice)

    get "/api/v1/invoices/find_all?updated_at=#{updated}"

    invoices = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(invoices[0]['attributes']["updated_at"]).to eq(updated)
    expect(invoices[1]['attributes']["updated_at"]).to eq(updated)
    expect(invoices[0]['attributes']["updated_at"]).to_not eq(invoice_3.updated_at)
  end

  it 'finds a random invoice' do
    invoice_1, invoice_2, invoice_3 = create_list(:invoice, 3)
    array_of_invoices_ids = [invoice_1.id, invoice_2.id, invoice_3.id]

    get '/api/v1/invoices/random.json'

    invoice = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(array_of_invoices_ids).to include(invoice['id'])
  end
end
