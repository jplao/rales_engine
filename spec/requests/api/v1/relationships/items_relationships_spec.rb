require 'rails_helper'

describe 'nested items resources API' do
  it 'sends invoice items specific to an item' do
    item_1, item_2 = create_list(:item, 2)
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, item: item_1)
    invoice_item_3 = create(:invoice_item, item: item_2)

    get "/api/v1/items/#{item_1.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"].count).to eq(2)
    expect(invoice_items["data"][0]['attributes']['item_id']).to eq(item_1.id)
    expect(invoice_items["data"][1]['attributes']['item_id']).to eq(item_1.id)
    expect(invoice_items["data"][0]['attributes']['item_id']).to_not eq(item_2.id)
  end
end
