class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show 
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    merchant = Merchant.find(params[:item][:merchant_id])
    render json: ItemSerializer.new(merchant.items.create!(item_params))
  end

  def update
    item = Item.find(params[:id])
    item.update!(item_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end