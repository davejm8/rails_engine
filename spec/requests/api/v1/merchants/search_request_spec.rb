require 'rails_helper'

describe 'merchant search' do
  before :each do
    @merchant1 = create(:merchant, name: 'Bobbert')
    @merchant2 = create(:merchant, name: 'Lupin')
    @merchant3 = create(:merchant, name: 'Dave')
    @merchant4 = create(:merchant, name: 'Mike')
    @merchant5 = create(:merchant, name: 'Bob')
  end

  describe 'search' do
    it 'can find a merchant by name' do
      get '/api/v1/merchants/search?name=bobbert'

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant[:id]).to eq("#{@merchant1.id}")
    end

    it 'can find a merchant with a partial entry' do
      get '/api/v1/merchants/search?name=da'

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(merchant[:id]).to eq("#{@merchant3.id}")
    end
  end
end