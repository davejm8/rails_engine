require 'rails_helper'

describe "Merchants by item API" do
  before :each do
    @merchant = create(:merchant)
    @item = create(:item, merchant_id: @merchant.id)
  end

  it 'returns a merchant object associated with an item' do
    get "/api/v1/items/#{@item.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)

    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to be_a(String)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)

    expect(response.status).to eq(200)
    expect(@item.merchant).to eq(@merchant)
  end

  it 'returns 404 if item not found' do
    get "/api/v1/items/1234567890232131231231/merchant"

    expect(status).to eq(404)
  end
end