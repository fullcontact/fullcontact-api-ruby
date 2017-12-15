require 'helper'

describe FullContact::Client::Stats do
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

      stub_get("stats.json").
          with(:query => {:apiKey => "api_key"}).
          to_return(:body => fixture("stats.json"), :headers => {:content_type => "application/json; charset=utf-8"})

      stub_get("company/lookup.json").
          with(:query => {:apiKey => "api_key", :period => "2012-08"}).
          to_return(:body => fixture("stats.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it 'should rubyize keys' do
      expect(FullContact.stats.status).to(eq(200))

      expect(FullContact.stats.planBasePrice).to(eq(99))
    end
  end
end
