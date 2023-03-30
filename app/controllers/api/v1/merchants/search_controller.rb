class Api::V1::Merchants::SearchController < ApplicationController
  def search
    if !params[:name] || params[:name] == ""
      render json: { error: "Please enter a search term" }, status: 400
    elsif Merchant.search(search_params) == nil
      render json: { data: {} }, status: 200
    else
      render json: MerchantSerializer.new(Merchant.search(search_params))
    end
  end

private

  def search_params
    params.require(:name)
  end
end