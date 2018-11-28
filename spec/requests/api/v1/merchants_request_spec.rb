require 'rails_helper'

describe 'Merchant API' do
  it 'sends a list of merchant' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'
    merchants = JSON.parse(response.body)['data']
    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end

  it 'sends a single merchant' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end

  it 'finds a single merchant by id' do
    merch_1 = create(:merchant).id
    merch_2 = create(:merchant)

    get "/api/v1/merchants/find?id=#{merch_1}"

    merchant = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(merchant["id"]).to eq(merch_1)
    expect(merchant["id"]).to_not eq(merch_2.id)
  end

  it 'finds a single merchant by name' do
    name = create(:merchant).name
    merch_2 = create(:merchant)

    get "/api/v1/merchants/find?name=#{name}"

    merchant = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(merchant["name"]).to eq(name)
    expect(merchant["name"]).to_not eq(merch_2.name)
  end

  it 'finds a single merchant by created_at' do
    merch_1 = create(:merchant, created_at: "2012-03-27T14:53:58.000Z")
    merch_2 = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{merch_1.created_at}"

    merchant = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(merchant["created_at"]).to eq("2012-03-27T14:53:58.000Z")
    expect(merchant["created_at"]).to_not eq(merch_2.created_at)
  end

  it 'finds a single merchant by updated_at' do
    merch_1 = create(:merchant, updated_at: "2012-03-27T14:53:58.000Z")
    merch_2 = create(:merchant)

    get "/api/v1/merchants/find?updated_at=#{merch_1.updated_at}"

    merchant = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(merchant["updated_at"]).to eq("2012-03-27T14:53:58.000Z")
    expect(merchant["updated_at"]).to_not eq(merch_2.updated_at)
  end

  it 'finds all merchants by id' do
    merch_1 = create(:merchant).id
    merch_2 = create(:merchant)

    get "/api/v1/merchants/find?id=#{merch_1}"

    merchant = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(merchant["id"]).to eq(merch_1)
    expect(merchant["id"]).to_not eq(merch_2.id)
  end

  it 'finds all merchants by name' do
    merch_name = 'A Merchant'
    merch_1, merch_2 = create_list(:merchant, 2, name: merch_name)
    merch_3 = create(:merchant)

    get "/api/v1/merchants/find_all?name=#{merch_1.name}"

    merchants = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchants[0]['attributes']["name"]).to eq(merch_name)
    expect(merchants[1]['attributes']["name"]).to eq(merch_name)
    expect(merchants[0]['attributes']["name"]).to_not eq(merch_3.name)
  end

  it 'finds all merchants by created_at' do
    created = "2012-03-27T14:53:58.000Z"
    merch_1, merch_2 = create_list(:merchant, 2, created_at: "2012-03-27T14:53:58.000Z")
    merch_3 = create(:merchant)

    get "/api/v1/merchants/find_all?created_at=#{created}"

    merchants = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchants[0]['attributes']["created_at"]).to eq(created)
    expect(merchants[1]['attributes']["created_at"]).to eq(created)
    expect(merchants[0]['attributes']["created_at"]).to_not eq(merch_3.created_at)
  end

  it 'finds all merchants by updated_at' do
    updated = "2012-03-27T14:53:58.000Z"
    merch_1, merch_2 = create_list(:merchant, 2, updated_at: "2012-03-27T14:53:58.000Z")
    merch_3 = create(:merchant)

    get "/api/v1/merchants/find_all?updated_at=#{updated}"

    merchants = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchants[0]['attributes']["updated_at"]).to eq(updated)
    expect(merchants[1]['attributes']["updated_at"]).to eq(updated)
    expect(merchants[0]['attributes']["updated_at"]).to_not eq(merch_3.updated_at)
  end

  it 'finds a random merchant' do
    merch_1, merch_2, merch_3 = create_list(:merchant, 3)
    array_of_merchants_ids = [merch_1.id, merch_2.id, merch_3.id]

    get '/api/v1/merchants/random.json'

    merchant = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(array_of_merchants_ids).to include(merchant['id'])
  end
end
