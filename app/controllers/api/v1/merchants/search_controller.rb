class Api::V1::Merchants::SearchController < ApplicationController
  def search
    render json: MerchantSerializer.new(Merchant.search(search_params))
  end

private

  def search_params
    params.require(:name)
  end
end