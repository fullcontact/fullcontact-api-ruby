require 'helper'

describe FullContact::Client::Person do
  FullContact::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = FullContact::Client.new(:format => format, :api_key => 'api_key')
      end

    end
  end

  context "when parsing a response" do

    before do
      FullContact.configure do |config|
        config.api_key = "api_key"
      end

      stub_get("person.json").
          with(:query => {:apiKey => "api_key", :email => "brawest@gmail.com"}).
          to_return(:body => fixture("person.json"), :headers => {:content_type => "application/json; charset=utf-8"})

      stub_get("person.json").
          with(:query => {:apiKey => "api_key", :twitter => "brawtest"}).
          to_return(:body => fixture("person.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it 'should rubyize keys' do
      expect(FullContact.person(email: "brawest@gmail.com").contact_info.given_name).to(eq("Brandon"))

      expect(FullContact.person(email: "brawest@gmail.com")).to satisfy do |v|
        v.keys.all? { |k| !k.match(/[A-Z]/) }
      end
    end
  end

  context "when parsing a response without rubyize" do

    before do
      FullContact.configure do |config|
        config.api_key = "api_key"
        config.skip_rubyize = true
      end

      stub_get("person.json").
          with(:query => {:apiKey => "api_key", :email => "brawest@gmail.com"}).
          to_return(:body => fixture("person.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it 'should not rubyize keys' do
      expect(FullContact.person(email: "brawest@gmail.com").contactInfo.givenName).to(eq("Brandon"))
    end
  end

  context "with headers enabled" do

    before do
      FullContact.configure do |config|
        config.api_key = "api_key"
        config.include_headers_in_response = true
      end

      stub_get("person.json").
          with(:query => {:apiKey => "api_key", :email => "brawest@gmail.com"}).
          to_return(:body => fixture("person.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it 'should include http headers from response' do
      expect(FullContact.person(email: "brawest@gmail.com").http_headers['content-type'])
          .to(eq("application/json; charset=utf-8"))
    end
  end
end
