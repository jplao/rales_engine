require 'rails_helper'

describe 'InvoiceItem API' do
  it 'sends a list of invoice_items' do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'
    invoice_items = JSON.parse(response.body)['data']
    expect(response).to be_successful
    expect(invoice_items.count).to eq(3)
  end

  it 'sends a single invoice_item' do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(invoice_item["id"]).to eq(id)
  end

  it 'finds a single invoice_item by id' do
    invoice_item_1 = create(:invoice_item).id
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?id=#{invoice_item_1}"

    invoice_item = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(invoice_item["id"]).to eq(invoice_item_1)
    expect(invoice_item["id"]).to_not eq(invoice_item_2.id)
  end

  it 'finds a single invoice_item by created_at' do
    invoice_item_1 = create(:invoice_item, created_at: "2012-03-27T14:53:58.000Z")
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?created_at=#{invoice_item_1.created_at}"

    invoice_item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice_item["created_at"]).to eq("2012-03-27T14:53:58.000Z")
    expect(invoice_item["created_at"]).to_not eq(invoice_item_2.created_at)
  end

  it 'finds a single invoice_item by updated_at' do
    invoice_item_1 = create(:invoice_item, updated_at: "2012-03-27T14:53:58.000Z")
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?updated_at=#{invoice_item_1.updated_at}"

    invoice_item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice_item["updated_at"]).to eq("2012-03-27T14:53:58.000Z")
    expect(invoice_item["updated_at"]).to_not eq(invoice_item_2.updated_at)
  end

  it 'finds all invoice_items by id' do
    invoice_item_1 = create(:invoice_item).id
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?id=#{invoice_item_1}"

    invoice_item = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(invoice_item["id"]).to eq(invoice_item_1)
    expect(invoice_item["id"]).to_not eq(invoice_item_2.id)
  end

  it 'finds all invoice_items by created_at' do
    created = "2012-03-27T14:53:58.000Z"
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, created_at: "2012-03-27T14:53:58.000Z")
    invoice_item_3 = create(:invoice_item)

    get "/api/v1/invoice_items/find_all?created_at=#{created}"

    invoice_items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(invoice_items[0]['attributes']["created_at"]).to eq(created)
    expect(invoice_items[1]['attributes']["created_at"]).to eq(created)
    expect(invoice_items[0]['attributes']["created_at"]).to_not eq(invoice_item_3.created_at)
  end

  it 'finds all invoice_items by updated_at' do
    updated = "2012-03-27T14:53:58.000Z"
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, updated_at: "2012-03-27T14:53:58.000Z")
    invoice_item_3 = create(:invoice_item)

    get "/api/v1/invoice_items/find_all?updated_at=#{updated}"

    invoice_items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(invoice_items[0]['attributes']["updated_at"]).to eq(updated)
    expect(invoice_items[1]['attributes']["updated_at"]).to eq(updated)
    expect(invoice_items[0]['attributes']["updated_at"]).to_not eq(invoice_item_3.updated_at)
  end

  it 'finds a random invoice_item' do
    invoice_item_1, invoice_item_2, invoice_item_3 = create_list(:invoice_item, 3)
    array_of_invoice_items_ids = [invoice_item_1.id, invoice_item_2.id, invoice_item_3.id]

    get '/api/v1/invoice_items/random.json'

    invoice_item = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(array_of_invoice_items_ids).to include(invoice_item['id'])
  end
end
