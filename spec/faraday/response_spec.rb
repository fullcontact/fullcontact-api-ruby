require 'helper'

describe Faraday::Response do
  before do
	RubyRainmaker.configure do |config|
		config.api_key = "api_key"
	end
    @client = RubyRainmaker::Client.new
  end

  {
    400 => RubyRainmaker::BadRequest,
    401 => RubyRainmaker::Unauthorized,
    403 => RubyRainmaker::Forbidden,
    404 => RubyRainmaker::NotFound,
    422 => RubyRainmaker::Invalid,
    500 => RubyRainmaker::InternalServerError,
    502 => RubyRainmaker::BadGateway,
    503 => RubyRainmaker::ServiceUnavailable,
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
