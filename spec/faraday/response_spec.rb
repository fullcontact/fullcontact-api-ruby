require 'helper'
require 'faraday'
require 'fullcontact'

describe Faraday::Response do
  before do
    FullContact.configure do |config|
      config.api_key = "api_key"
    end
    @client = FullContact::Client.new
  end

  {
      400 => FullContact::BadRequest,
      401 => FullContact::Unauthorized,
      403 => FullContact::Forbidden,
      404 => FullContact::NotFound,
      422 => FullContact::Invalid,
      429 => FullContact::RateLimited,
      500 => FullContact::InternalServerError,
      502 => FullContact::BadGateway,
      503 => FullContact::ServiceUnavailable,
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
            @client.person(:email => 'brawest@gmail.com')
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
              @client.person(:email => 'brawest@gmail.com')
            end.should raise_error(exception)
          end
        end
      end
    end
  end
end
