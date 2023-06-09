require 'rails_helper'

describe "Merchants Items API" do
  before :each do
    @merchant = create(:merchant)
  end

  it 'returns all items for a merchant' do
    create_list(:item, 5, merchant_id: @merchant.id)

    get "/api/v1/merchants/#{@merchant.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(5)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to eq(@merchant.id)
    end
  end

  it 'returns 404 if merchant does not exist' do
    get "/api/v1/merchants/2134125363457439999999999999/items"

    expect(status).to eq(404)
  end
  
  it 'returns an empty array if merchant has no items' do
    create_list(:item, 0, merchant_id: @merchant.id)
    get "/api/v1/merchants/#{@merchant.id}/items"
    
    expect(response).to be_successful
    
    items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(items).to eq([])
  end
end