require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'class methods' do
    describe '#search_all' do
      it 'can find all items by name' do
        merchant = create(:merchant)
        item1 = create(:item, name: 'soap', merchant: merchant)
        item2 = create(:item, name: 'soup', merchant: merchant)
        item3 = create(:item, name: 'soapstone', merchant: merchant)
        item4 = create(:item, name: 'salad', merchant: merchant)
        item5 = create(:item, name: 'zebra', merchant: merchant)
        
        expect(Item.search_all('s')).to eq([item4, item1, item3, item2])
      end
    end
  end
end
