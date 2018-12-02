require 'rails_helper'

describe 'Item API' do
  before(:each) do
    @item_1, @item_2, @item_3 = create_list(:item, 3)
    @item_4 = create(:item)
    @invoice_1 = create(:invoice, created_at: '2018-12-02T07:45:06.712Z')
    @invoice_2 = create(:invoice, created_at: 1.days.ago)
    ii_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 3, unit_price: 100)
    ii_2 = create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 4, unit_price: 200)
    ii_3 = create(:invoice_item, invoice: @invoice_2, item: @item_4, quantity: 2, unit_price: 300)
    ii_4 = create(:invoice_item, invoice: @invoice_2, item: @item_3, quantity: 1, unit_price: 100)
    ii_5 = create(:invoice_item, invoice: @invoice_2, item: @item_2, quantity: 1, unit_price: 200)
  end

  it 'sends a variable number of items that were sold the most' do

    get "/api/v1/items/most_items?quantity=3"

    items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(items.count).to eq(3)
    expect(items[0]['attributes']['id']).to eq(@item_2.id)
    expect(items[1]['attributes']['id']).to eq(@item_1.id)
    expect(items[2]['attributes']['id']).to eq(@item_4.id)
  end

  it 'sends a variable number of items that generate the most revenue' do

    get "/api/v1/items/most_revenue?quantity=3"

    items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(items.count).to eq(3)
    expect(items[0]['attributes']['id']).to eq(@item_2.id)
    expect(items[1]['attributes']['id']).to eq(@item_4.id)
    expect(items[2]['attributes']['id']).to eq(@item_1.id)
  end

  it 'sends an individual items best day' do

    get "/api/v1/items/#{@item_2.id}/best_day"

    day = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(day['attributes']['best_day']).to eq('2018-12-02T07:45:06.712Z')
  end
end
