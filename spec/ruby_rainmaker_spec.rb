require 'helper'

describe RubyRainmaker do
  after do
    RubyRainmaker.reset
  end

  context "when delegating to a client" do

    before do
		RubyRainmaker.configure do |config|
			config.api_key = "api_key"
		end

		stub_get("person.json").
		  with(:query => {:apiKey => "api_key", :email => "brawest@gmail.com"}).
		  to_return(:body => fixture("person.json"), :headers => {:content_type => "application/json; charset=utf-8"})

    end

    it "should get the correct resource" do
      RubyRainmaker.person("brawest@gmail.com")
      a_get("person.json").with(:query => {:apiKey => "api_key", :email => "brawest@gmail.com"}).should have_been_made
    end

    it "should return the same results as a client" do
      RubyRainmaker.person("brawest@gmail.com").should == RubyRainmaker::Client.new.person("brawest@gmail.com")
    end

  end

  describe '.respond_to?' do
    it 'takes an optional include private argument' do
      RubyRainmaker.respond_to?(:client, true).should be_true
    end
  end

  describe ".client" do
    it "should be a RubyRainmaker::Client" do
      RubyRainmaker.client.should be_a RubyRainmaker::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      RubyRainmaker.adapter.should == RubyRainmaker::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      RubyRainmaker.adapter = :typhoeus
      RubyRainmaker.adapter.should == :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      RubyRainmaker.endpoint.should == RubyRainmaker::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      RubyRainmaker.endpoint = 'http://tumblr.com/'
      RubyRainmaker.endpoint.should == 'http://tumblr.com/'
    end
  end

  describe ".format" do
    it "should return the default format" do
      RubyRainmaker.format.should == RubyRainmaker::Configuration::DEFAULT_FORMAT
    end
  end

  describe ".format=" do
    it "should set the format" do
      RubyRainmaker.format = 'xml'
      RubyRainmaker.format.should == 'xml'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      RubyRainmaker.user_agent.should == RubyRainmaker::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      RubyRainmaker.user_agent = 'Custom User Agent'
      RubyRainmaker.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do

    RubyRainmaker::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        RubyRainmaker.configure do |config|
          config.send("#{key}=", key)
          RubyRainmaker.send(key).should == key
        end
      end
    end
  end
end
