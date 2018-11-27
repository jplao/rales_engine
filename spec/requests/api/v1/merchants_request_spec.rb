require 'rails_helper'

describe 'Merchant API' do
  it 'sends a list of merchant' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end

  it 'sends a merchant' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end
end
