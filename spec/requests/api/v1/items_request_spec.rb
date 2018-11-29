require 'rails_helper'

describe 'Item API' do
  it 'sends a list of items' do
    create_list(:item, 3)

    get '/api/v1/items'
    items = JSON.parse(response.body)['data']
    expect(response).to be_successful
    expect(items.count).to eq(3)
  end

  it 'sends a single item' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end

  it 'finds a single item by id' do
    item_1 = create(:item).id
    item_2 = create(:item)

    get "/api/v1/items/find?id=#{item_1}"

    item = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(item["id"]).to eq(item_1)
    expect(item["id"]).to_not eq(item_2.id)
  end

  it 'finds a single item by name' do
    name = create(:item).name
    item_2 = create(:item)

    get "/api/v1/items/find?name=#{name}"

    item = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(item["name"]).to eq(name)
    expect(item["name"]).to_not eq(item_2.name)
  end

  it 'finds a single item by created_at' do
    item_1 = create(:item, created_at: "2012-03-27T14:53:58.000Z")
    item_2 = create(:item)

    get "/api/v1/items/find?created_at=#{item_1.created_at}"

    item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(item["created_at"]).to eq("2012-03-27T14:53:58.000Z")
    expect(item["created_at"]).to_not eq(item_2.created_at)
  end

  it 'finds a single item by updated_at' do
    item_1 = create(:item, updated_at: "2012-03-27T14:53:58.000Z")
    item_2 = create(:item)

    get "/api/v1/items/find?updated_at=#{item_1.updated_at}"

    item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(item["updated_at"]).to eq("2012-03-27T14:53:58.000Z")
    expect(item["updated_at"]).to_not eq(item_2.updated_at)
  end

  it 'finds all items by id' do
    item_1 = create(:item).id
    item_2 = create(:item)

    get "/api/v1/items/find?id=#{item_1}"

    item = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(item["id"]).to eq(item_1)
    expect(item["id"]).to_not eq(item_2.id)
  end

  it 'finds all items by name' do
    item_name = 'A Item'
    item_1, item_2 = create_list(:item, 2, name: item_name)
    item_3 = create(:item)

    get "/api/v1/items/find_all?name=#{item_1.name}"

    items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(items[0]['attributes']["name"]).to eq(item_name)
    expect(items[1]['attributes']["name"]).to eq(item_name)
    expect(items[0]['attributes']["name"]).to_not eq(item_3.name)
  end

  it 'finds all items by created_at' do
    created = "2012-03-27T14:53:58.000Z"
    item_1, item_2 = create_list(:item, 2, created_at: "2012-03-27T14:53:58.000Z")
    item_3 = create(:item)

    get "/api/v1/items/find_all?created_at=#{created}"

    items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(items[0]['attributes']["created_at"]).to eq(created)
    expect(items[1]['attributes']["created_at"]).to eq(created)
    expect(items[0]['attributes']["created_at"]).to_not eq(item_3.created_at)
  end

  it 'finds all items by updated_at' do
    updated = "2012-03-27T14:53:58.000Z"
    item_1, item_2 = create_list(:item, 2, updated_at: "2012-03-27T14:53:58.000Z")
    item_3 = create(:item)

    get "/api/v1/items/find_all?updated_at=#{updated}"

    items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(items[0]['attributes']["updated_at"]).to eq(updated)
    expect(items[1]['attributes']["updated_at"]).to eq(updated)
    expect(items[0]['attributes']["updated_at"]).to_not eq(item_3.updated_at)
  end

  it 'finds a random item' do
    item_1, item_2, item_3 = create_list(:item, 3)
    array_of_items_ids = [item_1.id, item_2.id, item_3.id]

    get '/api/v1/items/random.json'

    item = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(array_of_items_ids).to include(item['id'])
  end
end
