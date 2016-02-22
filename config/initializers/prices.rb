# Create a dataset of product prices
PRODUCT_PRICES = []

101.times do
  # some random prices
  price = rand(1..10_000)

  # Premium members get a 10% discount
  PRODUCT_PRICES << { standard_price: price, premium_price: price * 0.9 }
end
