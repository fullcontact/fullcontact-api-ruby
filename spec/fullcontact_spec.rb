require 'fullcontact'
require 'helper'

describe FullContact do
  after do
    FullContact.reset
  end

  context "when delegating to a client" do

    before do
		FullContact.configure do |config|
			config.api_key = "api_key"
		end

		stub_get("person.json").
		  with(:query => {:apiKey => "api_key", :email => "brawest@gmail.com"}).
		  to_return(:body => fixture("person.json"), :headers => {:content_type => "application/json; charset=utf-8"})

    end

    it "should get the correct resource" do
      FullContact.person("brawest@gmail.com")
      a_get("person.json")
	  .with(:query => {:apiKey => "api_key", :email => "brawest@gmail.com"})
	  .should have_been_made
    end

    it "should return the same results as a client" do
      FullContact.person("brawest@gmail.com").should == FullContact::Client.new.person("brawest@gmail.com")
    end

  end

  describe '.respond_to?' do
    it 'takes an optional include private argument' do
      FullContact.respond_to?(:client, true).should be_true
    end
  end

  describe ".client" do
    it "should be a FullContact::Client" do
      FullContact.client.should be_a FullContact::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      FullContact.adapter.should == FullContact::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      FullContact.adapter = :typhoeus
      FullContact.adapter.should == :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      FullContact.endpoint.should == FullContact::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      FullContact.endpoint = 'http://tumblr.com/'
      FullContact.endpoint.should == 'http://tumblr.com/'
    end
  end

  describe ".format" do
    it "should return the default format" do
      FullContact.format.should == FullContact::Configuration::DEFAULT_FORMAT
    end
  end

  describe ".format=" do
    it "should set the format" do
      FullContact.format = 'xml'
      FullContact.format.should == 'xml'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      FullContact.user_agent.should == FullContact::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      FullContact.user_agent = 'Custom User Agent'
      FullContact.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do

    FullContact::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        FullContact.configure do |config|
          config.send("#{key}=", key)
          FullContact.send(key).should == key
        end
      end
    end
  end
end
