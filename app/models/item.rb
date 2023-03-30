class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  def self.search_all(params)
    where("name ILIKE ?", "%#{params}%").order(:name)
  end

  def self.search_by_price(min, max)
		if min != nil && max != nil
			where("unit_price >= ? AND unit_price <= ?", min, max)
			
		elsif max == nil
			where("unit_price >= ?", min)
			
		else min == nil
			where("unit_price <= ?", max)
		end
		.order(:unit_price)
	end
end