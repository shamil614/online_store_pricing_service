 class PriceServer < CarrotRpc::RpcServer
   queue_name "price_server"

  def create(params)
    # Pricing Dataset
    product = PRODUCT_PRICES[params["id"]]

    if params["status"] == "premium"
      calculated_price = product[:premium_price]
    else
      calculated_price = product[:standard_price]
    end

    { calculated_price: calculated_price, standard_price: product[:standard_price] }
  end
end
