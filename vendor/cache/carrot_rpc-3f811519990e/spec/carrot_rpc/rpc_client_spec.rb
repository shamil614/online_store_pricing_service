require "spec_helper"
require "carrot_rpc"

RSpec.describe CarrotRpc::RpcClient do
  subject(:client) {
    client_class.new
  }

  let(:client_class) {
    Class.new(CarrotRpc::RpcClient)
  }

  describe "#queue_name" do
    it "has a queue name class method" do
      client_class.queue_name "foo"
      expect(client_class.queue_name).to eq "foo"
    end

    context "during #initialize" do
      # lets

      let(:channel) {
        instance_double(Bunny::Channel, default_exchange: nil)
      }

      # Callbacks

      before(:each) do
        allow(CarrotRpc.configuration.bunny).to receive(:create_channel).and_return(channel)
      end

      it "does not default queue name" do
        expect(channel).to receive(:queue).with(nil, auto_delete: false)

        client
      end
    end
  end

  describe "#start" do
    # Methods

    def delete_queue
      channel = CarrotRpc.configuration.bunny.create_channel
      queue = channel.queue("foo")
      queue.delete
      channel.close
    end

    # lets

    let(:client) {
      client_class.new
    }

    let(:client_class) {
      Class.new(CarrotRpc::RpcClient) do
        queue_name "foo"
      end
    }

    let(:server) {
      server_class.new(block: false)
    }

    let(:server_class) {
      Class.new(CarrotRpc::RpcServer) do
        queue_name "foo"

        # Instance Methods

        def show(_params)
          {
            "foo-baz" => {
              "biz-baz" => {
                "super-duper" => "grovy"
              },
              "fizz-buzz" => "baz",
              "foo-bar" => "biz"
            }
          }
        end
      end
    }

    # Callbacks

    before(:each) do
      # Delete queue if another test did not clean up properly, such as due to interrupt
      delete_queue

      server.start
    end

    after(:each) do
      client.channel.close
      server.channel.close

      # Clean up properly
      delete_queue
    end

    context "with client started" do
      # lets

      let(:result) do
        {
          "foo_baz" => {
            "biz_baz" => {
              "super_duper" => "grovy"
            },
            "fizz_buzz" => "baz",
            "foo_bar" => "biz"
          }
        }
      end

      # Callbacks

      before(:each) do
        client.start
      end

      it "parses the payload from json to hash and changes '-' to '_' in the keys" do
        expect(client.show({})).to eq result
      end
    end
  end
end
