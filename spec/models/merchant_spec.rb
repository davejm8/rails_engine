require 'rails_helper'

describe Merchant do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'class methods' do
    describe '#search' do
      it 'can find a merchant by name' do
        merchant1 = create(:merchant, name: 'Bobbert')
        merchant2 = create(:merchant, name: 'Barber')

        expect(Merchant.search('bo')).to eq(merchant1)
      end
    end
  end
end
