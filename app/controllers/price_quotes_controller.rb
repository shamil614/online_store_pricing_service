class PriceQuotesController < ApplicationController
  def create
    # Pricing Dataset
    product = PRODUCT_PRICES[params["id"].to_i]

    if params["status"] == "premium"
      calculated_price = product[:premium_price]
    else
      calculated_price = product[:standard_price]
    end

    render json: { calculated_price: calculated_price, standard_price: product[:standard_price] }
  end
end
