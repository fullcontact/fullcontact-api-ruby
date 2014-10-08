require 'helper'

describe FullContact::Client do
  it "should connect using the endpoint configuration" do
    client = FullContact::Client.new
    endpoint = URI.parse(client.api_endpoint)
    connection = "#{client.send(:connection).build_url(nil).to_s}"
    connection.should == endpoint.to_s
  end
end
