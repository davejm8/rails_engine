class Api::V1::Items::SearchController < ApplicationController
  def search_all
    if (params[:name] && (params[:min_price] || params[:max_price]))
      render json: ErrorSerializer.invalid_parameters("Can not send price with name"), status: 400
    elsif params[:name]
      render json: ItemSerializer.new(Item.search_all(params[:name]))
    else (params[:min_price] || params[:max_price])
      items = Item.search_by_price(params[:min_price], params[:max_price])
        if items.nil?
          render json: ErrorSerializer.no_matches_found("no matches found"), status: 400
        else
          render json: ItemSerializer.new(items)
        end
    end
  end
end