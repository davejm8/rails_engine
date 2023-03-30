class Api::V1::Items::SearchController < ApplicationController
  def search_all
    if (params[:name] && (params[:min_price] || params[:max_price]))
      render json: ErrorSerializer.invalid_parameters("Can not send price with name"), status: 400
    elsif params[:name]
      name
    else (params[:min_price] || params[:max_price])
      price
    end
  end

  private

  def name
    if params[:name].empty?
      render json: ErrorSerializer.invalid_parameters("No matches found"), status: :not_found
    else
      render json: ItemSerializer.new(Item.search_all(params[:name]))
    end
  end

  def price
    if params[:min_price].to_f < 0 || params[:max_price].to_f < 0
      render json: ErrorSerializer.no_matches_found("Price can not be under 0"), status: 400
    else
      items = Item.search_by_price(params[:min_price], params[:max_price])
        if items.empty?
          render json: ErrorSerializer.no_matches_found("No matches found"), status: 400
        else
          render json: ItemSerializer.new(items)
        end
    end
  end
end