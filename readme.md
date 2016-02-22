# A simple Pricing Service
The purpose is to delegate the pricing logic for the [online store](https://github.com/shamil614/online_store)
to a decoupled service. When the rails app starts a dataset of random prices is generated.
When a request comes in, if the request indicates a premium user, a discount is applied, and the calculated price is returned.

There's two ways to run the service.  AMQP via bunny, or HTTP with Puma.

## Install
1. Make sure to have RabbitMQ installed via homebrew, or see the [installation guide](https://www.rabbitmq.com/download.html).
2. Clone the repo: `git clone https://github.com/shamil614/online_store.git`
3. Install gems via bundler. `bundle`
    
## Starting the AMQP based service
  1. start rabbitmq in a terminal window with `rabbitmq-server`
  2. cd into project directory
  3. in another terminal window start carrot_rpc with `carrot_rpc`

## Starting web service
1. cd into project directroy.
2. start puma `bundle exec puma -C config/puma.rb` 
3. Puma should shart on ```localhost:9292```
