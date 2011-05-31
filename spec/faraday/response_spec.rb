require 'helper'
require 'faraday'
require 'rainmaker'

describe Faraday::Response do
  before do
	Rainmaker.configure do |config|
		config.api_key = "api_key"
	end
    @client = Rainmaker::Client.new
  end

  {
    400 => Rainmaker::BadRequest,
    401 => Rainmaker::Unauthorized,
    403 => Rainmaker::Forbidden,
    404 => Rainmaker::NotFound,
    422 => Rainmaker::Invalid,
    500 => Rainmaker::InternalServerError,
    502 => Rainmaker::BadGateway,
    503 => Rainmaker::ServiceUnavailable,
  }.each do |status, exception|
    if (status >= 500)
      context "when HTTP status is #{status}" do
        before do
          stub_get('person.json').
            with(:query => {:apiKey => "api_key", :email => 'brawest@gmail.com'}).
            to_return(:status => status)
        end

        it "should raise #{exception.name} error" do
          lambda do
            @client.person( 'brawest@gmail.com')
          end.should raise_error(exception)
        end
      end
    else
      [nil, "error", "errors"].each do |body|
        context "when HTTP status is #{status} and body is #{body||='nil'}" do
          before do
            body_message = '{"'+body+'":"test"}' unless body.nil?
         	stub_get('person.json').
				with(:query => {:apiKey => "api_key", :email => 'brawest@gmail.com'}).
               to_return(:status => status, :body => body_message)
          end

          it "should raise #{exception.name} error" do
            lambda do
             @client.person( 'brawest@gmail.com')
            end.should raise_error(exception)
          end
        end
      end
    end
  end
end
