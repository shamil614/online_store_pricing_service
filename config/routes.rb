Rails.application.routes.draw do
  post "/price_quote", to: "price_quotes#create"
end
