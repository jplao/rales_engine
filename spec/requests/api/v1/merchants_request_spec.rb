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
    merchant_1 = create(:merchant).id
    merchant_2 = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant_1}"

    merchant = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(merchant["id"]).to eq(merchant_1)
    expect(merchant["id"]).to_not eq(merchant_2.id)
  end

  it 'finds a single merchant by name' do
    name = create(:merchant).name
    merchant_2 = create(:merchant)

    get "/api/v1/merchants/find?name=#{name}"

    merchant = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(merchant["name"]).to eq(name)
    expect(merchant["name"]).to_not eq(merchant_2.name)
  end

  it 'finds a single merchant by created_at' do
    merchant_1 = create(:merchant, created_at: "2012-03-27T14:53:58.000Z")
    merchant_2 = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{merchant_1.created_at}"

    merchant = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(merchant['id']).to eq(merchant_1.id)
    expect(merchant['id']).to_not eq(merchant_2.id)
  end

  it 'finds a single merchant by updated_at' do
    merchant_1 = create(:merchant, updated_at: "2012-03-27T14:53:58.000Z")
    merchant_2 = create(:merchant)

    get "/api/v1/merchants/find?updated_at=#{merchant_1.updated_at}"

    merchant = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(merchant['id']).to eq(merchant_1.id)
    expect(merchant['id']).to_not eq(merchant_2.id)
  end

  it 'finds all merchants by id' do
    merchant_1 = create(:merchant).id
    merchant_2 = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant_1}"

    merchant = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(merchant["id"]).to eq(merchant_1)
    expect(merchant["id"]).to_not eq(merchant_2.id)
  end

  it 'finds all merchants by name' do
    merchant_name = 'A Merchant'
    merchant_1, merchant_2 = create_list(:merchant, 2, name: merchant_name)
    merchant_3 = create(:merchant)

    get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

    merchants = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchants[0]['attributes']["name"]).to eq(merchant_name)
    expect(merchants[1]['attributes']["name"]).to eq(merchant_name)
    expect(merchants[0]['attributes']["name"]).to_not eq(merchant_3.name)
  end

  it 'finds all merchants by created_at' do
    created = "2012-03-27T14:53:58.000Z"
    merchant_1, merchant_2 = create_list(:merchant, 2, created_at: "2012-03-27T14:53:58.000Z")
    merchant_3 = create(:merchant)

    get "/api/v1/merchants/find_all?created_at=#{created}"

    merchants = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchants[0]['attributes']['id']).to eq(merchant_1.id)
    expect(merchants[1]['attributes']['id']).to eq(merchant_2.id)
    expect(merchants).to_not include(merchant_3.id)
  end

  it 'finds all merchants by updated_at' do
    updated = "2012-03-27T14:53:58.000Z"
    merchant_1, merchant_2 = create_list(:merchant, 2, updated_at: "2012-03-27T14:53:58.000Z")
    merchant_3 = create(:merchant)

    get "/api/v1/merchants/find_all?updated_at=#{updated}"

    merchants = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchants[0]['attributes']['id']).to eq(merchant_1.id)
    expect(merchants[1]['attributes']['id']).to eq(merchant_2.id)
    expect(merchants).to_not include(merchant_3.id)
  end

  it 'finds a random merchant' do
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3)
    array_of_merchants_ids = [merchant_1.id, merchant_2.id, merchant_3.id]

    get '/api/v1/merchants/random.json'

    merchant = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(array_of_merchants_ids).to include(merchant['id'])
  end
end
