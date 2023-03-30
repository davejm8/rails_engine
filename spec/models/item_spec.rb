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

    describe '#search_by_price' do
      it 'can find all items by price' do
        merchant = create(:merchant)
        item1 = create(:item, unit_price: 50.00, merchant: merchant)
        item2 = create(:item, unit_price: 60.00, merchant: merchant)
        item3 = create(:item, unit_price: 70.00, merchant: merchant)
        item4 = create(:item, unit_price: 80.00, merchant: merchant)
        item5 = create(:item, unit_price: 120.00, merchant: merchant)
        
        expect(Item.search_by_price(50, 80)).to eq([item1, item2, item3, item4])
      end
    end
  end
end
