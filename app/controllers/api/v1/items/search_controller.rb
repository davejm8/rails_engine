class Api::V1::Items::SearchController < ApplicationController
  def search_all
    render json: ItemSerializer.new(Item.search_all(search_params))
  end

private

  def search_params
    params.require(:name)
  end
end