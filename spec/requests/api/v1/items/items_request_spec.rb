require 'rails_helper'

describe "Items API" do

  before :each do
    @merchant = create(:merchant)
    @item1 = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)
    @item3 = create(:item, merchant: @merchant)
    @item4 = create(:item, merchant: @merchant)
    @item5 = create(:item, merchant: @merchant)
    # require 'pry'; binding.pry
    # @invoice1 = create(:invoice, merchant: @merchant)
    # @invoice2 = create(:invoice, merchant: @merchant)
    # @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @item1)
    # @invoice_item2 = create(:invoice_item, invoice: @invoice1, item: @item2)
    # @invoice_item3 = create(:invoice_item, invoice: @invoice2, item: @item3)
    # @invoice_item4 = create(:invoice_item, invoice: @invoice2, item: @item4)
    # @invoice_item5 = create(:invoice_item, invoice: @invoice2, item: @item5)
  end

  it 'sends a list of all items' do
    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(5)

    items.each do |item|
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
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it 'can get one item by its id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(item[:id]).to be_a(String)

    expect(item).to have_key(:type)
    expect(item[:type]).to be_a(String)

    expect(item).to have_key(:attributes)
    expect(item[:attributes][:name]).to be_a(String)

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)
  end

  # it 'returns status 404 if item is not found' do
  #   get '/api/v1/items/999999999'

  #   expect(status).to eq 404
  # end

  describe 'create' do
    it 'can create a new item' do
      item_params = ({
                    name: 'soap',
                    description: 'washes you',
                    unit_price: 2.5,
                    merchant_id: @merchant.id
                  })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(item.name).to eq(item_params[:name])
      expect(item.description).to eq(item_params[:description])
      expect(item.unit_price).to eq(item_params[:unit_price])
      expect(item.merchant_id).to eq(item_params[:merchant_id])
    end
  end

  describe 'update' do
    it 'can update an existing item' do
      id = create(:item).id
      previous_name = Item.last.name
      item_params = { name: 'not soap' }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq('not soap')
    end
  end
end