require 'rails_helper'


describe 'Customer API' do
  it 'sends a list of customers' do
    create_list(:customer, 3)

    get '/api/v1/customers'
    customers = JSON.parse(response.body)['data']
    expect(response).to be_successful
    expect(customers.count).to eq(3)
  end

  it 'sends a single customer' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(customer["id"]).to eq(id)
  end

  it 'finds a single customer by id' do
    customer_1 = create(:customer).id
    customer_2 = create(:customer)

    get "/api/v1/customers/find?id=#{customer_1}"

    customer = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(customer["id"]).to eq(customer_1)
    expect(customer["id"]).to_not eq(customer_2.id)
  end

  it 'finds a single customer by name' do
    name = create(:customer).first_name
    customer_2 = create(:customer)

    get "/api/v1/customers/find?first_name=#{name}"

    customer = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(customer["first_name"]).to eq(name)
    expect(customer["first_name"]).to_not eq(customer_2.first_name)
  end

  it 'finds a single customer by created_at' do
    customer_1 = create(:customer, created_at: "2012-03-27T14:53:58.000Z")
    customer_2 = create(:customer)

    get "/api/v1/customers/find?created_at=#{customer_1.created_at}"

    customer = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(customer['id']).to eq(customer_1.id)
    expect(customer['id']).to_not eq(customer_2.id)
  end

  it 'finds a single customer by updated_at' do
    customer_1 = create(:customer, updated_at: "2012-03-27T14:53:58.000Z")
    customer_2 = create(:customer)

    get "/api/v1/customers/find?updated_at=#{customer_1.updated_at}"

    customer = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(customer['id']).to eq(customer_1.id)
    expect(customer['id']).to_not eq(customer_2.id)
  end

  it 'finds all customers by id' do
    customer_1 = create(:customer).id
    customer_2 = create(:customer)

    get "/api/v1/customers/find?id=#{customer_1}"

    customer = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(customer["id"]).to eq(customer_1)
    expect(customer["id"]).to_not eq(customer_2.id)
  end

  it 'finds all customers by name' do
    customer_name = 'Customer'
    customer_1, customer_2 = create_list(:customer, 2, first_name: customer_name)
    customer_3 = create(:customer)

    get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"

    customers = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(customers[0]['attributes']["first_name"]).to eq(customer_name)
    expect(customers[1]['attributes']["first_name"]).to eq(customer_name)
    expect(customers[0]['attributes']["first_name"]).to_not eq(customer_3.first_name)
  end

  it 'finds all customers by created_at' do
    created = "2012-03-27T14:53:58.000Z"
    customer_1, customer_2 = create_list(:customer, 2, created_at: "2012-03-27T14:53:58.000Z")
    customer_3 = create(:customer)

    get "/api/v1/customers/find_all?created_at=#{created}"

    customers = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(customers[0]['attributes']['id']).to eq(customer_1.id)
    expect(customers[1]['attributes']['id']).to eq(customer_2.id)
    expect(customers).to_not include(customer_3.id)
  end

  it 'finds all customers by updated_at' do
    updated = "2012-03-27T14:53:58.000Z"
    customer_1, customer_2 = create_list(:customer, 2, updated_at: "2012-03-27T14:53:58.000Z")
    customer_3 = create(:customer)

    get "/api/v1/customers/find_all?updated_at=#{updated}"

    customers = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(customers[0]['attributes']['id']).to eq(customer_1.id)
    expect(customers[1]['attributes']['id']).to eq(customer_2.id)
    expect(customers).to_not include(customer_3.id)
  end

  it 'finds a random customer' do
    customer_1, customer_2, customer_3 = create_list(:customer, 3)
    array_of_customers_ids = [customer_1.id, customer_2.id, customer_3.id]

    get '/api/v1/customers/random.json'

    customer = JSON.parse(response.body)['data']['attributes']
    expect(response).to be_successful
    expect(array_of_customers_ids).to include(customer['id'])
  end
end
