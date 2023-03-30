require 'rails_helper'

describe 'item search_all' do
  before :each do
    @item1 = create(:item, name: 'soap', unit_price: 50.00)
    @item2 = create(:item, name: 'soup', unit_price: 60.00)
    @item3 = create(:item, name: 'soapstone', unit_price: 70.00)
    @item4 = create(:item, name: 'salad', unit_price: 80.00)
    @item5 = create(:item, name: 'zebra', unit_price: 120.00)
    @item6 = create(:item, name: 'meep', unit_price: 40.00)
  end

  describe 'search_all' do
    it 'can search all items by name' do
      get '/api/v1/items/search_all?name=s'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(items.count).to eq(4)
      expect(items[0][:id]).to eq("#{@item4.id}")
      expect(items[1][:id]).to eq("#{@item1.id}")
      expect(items[2][:id]).to eq("#{@item3.id}")
      expect(items[3][:id]).to eq("#{@item2.id}")
    end

    it 'returns empty array if no items match' do
      get '/api/v1/items/search_all?name=x'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(items).to eq([])
    end
  end

  describe 'search_by_price' do
    it 'can find all items by min price' do
      get '/api/v1/items/search_all?min_price=50'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(items.count).to eq(5)
      expect(items[0][:id]).to eq("#{@item1.id}")
      expect(items[1][:id]).to eq("#{@item2.id}")
      expect(items[2][:id]).to eq("#{@item3.id}")
      expect(items[3][:id]).to eq("#{@item4.id}")
      expect(items[4][:id]).to eq("#{@item5.id}")
    end

    it 'can find all items by max price' do
      get '/api/v1/items/search_all?max_price=70'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(items.count).to eq(4)
      expect(items[0][:id]).to eq("#{@item6.id}")
      expect(items[1][:id]).to eq("#{@item1.id}")
      expect(items[2][:id]).to eq("#{@item2.id}")
      expect(items[3][:id]).to eq("#{@item3.id}")
    end

    it 'can find all items by min and max price' do
      get '/api/v1/items/search_all?min_price=50&max_price=70'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(items.count).to eq(3)
      expect(items[0][:id]).to eq("#{@item1.id}")
      expect(items[1][:id]).to eq("#{@item2.id}")
      expect(items[2][:id]).to eq("#{@item3.id}")
    end

    it 'returns an error if a name and price are given' do
      get '/api/v1/items/search_all?name=s&min_price=50'

      expect(status).to eq(400)
    end
  end
end