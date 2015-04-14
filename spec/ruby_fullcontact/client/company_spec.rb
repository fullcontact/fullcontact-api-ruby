require 'helper'

describe FullContact::Client::Company do
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

      stub_get("company/lookup.json").
          with(:query => {:apiKey => "api_key", :domain => "fullcontact.com"}).
          to_return(:body => fixture("company.json"), :headers => {:content_type => "application/json; charset=utf-8"})

      stub_get("company/lookup.json").
          with(:query => {:apiKey => "api_key", :domain => "fullcontact.com"}).
          to_return(:body => fixture("company.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it 'should rubyize keys' do
      expect(FullContact.company(domain: "fullcontact.com").organization.name).to(eq("FullContact Inc."))

      expect(FullContact.company(domain: "fullcontact.com")).to satisfy do |v|
        v.keys.all? { |k| !k.match(/[A-Z]/) }
      end
    end
  end
end
