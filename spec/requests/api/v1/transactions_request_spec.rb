require 'rails_helper'

describe 'Transaction API' do
  it 'sends a list of transactions' do
    create_list(:transaction, 3)

    get '/api/v1/transactions'
    transactions = JSON.parse(response.body)['data']
    expect(response).to be_successful
    expect(transactions.count).to eq(3)
  end

  it 'sends a single transaction' do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(transaction["id"]).to eq(id)
  end

  it 'finds a single transaction by id' do
    transaction_1 = create(:transaction).id
    transaction_2 = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction_1}"

    transaction = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(transaction["id"]).to eq(transaction_1)
    expect(transaction["id"]).to_not eq(transaction_2.id)
  end

  it 'finds a single transaction by created_at' do
    transaction_1 = create(:transaction, created_at: "2012-03-27T14:53:58.000Z")
    transaction_2 = create(:transaction)

    get "/api/v1/transactions/find?created_at=#{transaction_1.created_at}"

    transaction = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(transaction["created_at"]).to eq("2012-03-27T14:53:58.000Z")
    expect(transaction["created_at"]).to_not eq(transaction_2.created_at)
  end

  it 'finds a single transaction by updated_at' do
    transaction_1 = create(:transaction, updated_at: "2012-03-27T14:53:58.000Z")
    transaction_2 = create(:transaction)

    get "/api/v1/transactions/find?updated_at=#{transaction_1.updated_at}"

    transaction = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(transaction["updated_at"]).to eq("2012-03-27T14:53:58.000Z")
    expect(transaction["updated_at"]).to_not eq(transaction_2.updated_at)
  end

  it 'finds all transactions by id' do
    transaction_1 = create(:transaction).id
    transaction_2 = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction_1}"

    transaction = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(transaction["id"]).to eq(transaction_1)
    expect(transaction["id"]).to_not eq(transaction_2.id)
  end

  it 'finds all transactions by created_at' do
    created = "2012-03-27T14:53:58.000Z"
    transaction_1, transaction_2 = create_list(:transaction, 2, created_at: "2012-03-27T14:53:58.000Z")
    transaction_3 = create(:transaction)

    get "/api/v1/transactions/find_all?created_at=#{created}"

    transactions = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(transactions[0]['attributes']["created_at"]).to eq(created)
    expect(transactions[1]['attributes']["created_at"]).to eq(created)
    expect(transactions[0]['attributes']["created_at"]).to_not eq(transaction_3.created_at)
  end

  it 'finds all transactions by updated_at' do
    updated = "2012-03-27T14:53:58.000Z"
    transaction_1, transaction_2 = create_list(:transaction, 2, updated_at: "2012-03-27T14:53:58.000Z")
    transaction_3 = create(:transaction)

    get "/api/v1/transactions/find_all?updated_at=#{updated}"

    transactions = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(transactions[0]['attributes']["updated_at"]).to eq(updated)
    expect(transactions[1]['attributes']["updated_at"]).to eq(updated)
    expect(transactions[0]['attributes']["updated_at"]).to_not eq(transaction_3.updated_at)
  end

  it 'finds a random transaction' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)
    array_of_transactions_ids = [transaction_1.id, transaction_2.id, transaction_3.id]

    get '/api/v1/transactions/random.json'

    transaction = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(array_of_transactions_ids).to include(transaction['id'])
  end
end
