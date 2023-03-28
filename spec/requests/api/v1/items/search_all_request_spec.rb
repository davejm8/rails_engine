require 'rails_helper'

describe 'item search_all' do
  before :each do
    @item1 = create(:item, name: 'soap')
    @item2 = create(:item, name: 'soup')
    @item3 = create(:item, name: 'soapstone')
    @item4 = create(:item, name: 'salad')
    @item5 = create(:item, name: 'zebra')
  end

  describe 'search_all' do
    it 'can find all items by name' do
      get '/api/v1/items/search_all?name=s'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(items.count).to eq(4)
      expect(items[0][:id]).to eq("#{@item4.id}")
      expect(items[1][:id]).to eq("#{@item1.id}")
      expect(items[2][:id]).to eq("#{@item3.id}")
      expect(items[3][:id]).to eq("#{@item2.id}")
    end
  end
end