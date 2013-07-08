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
    end

    ['json', 'xml'].each do |format|
      describe "using #{format} format" do
        before do
          FullContact.format = format
        end

        describe "#person" do
          before do
            stub_get("person.#{format}").
              with(:query => {:apiKey => "api_key", :email => "brawest@gmail.com"}).
              to_return(:body => fixture("person.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})

            stub_get("person.#{format}").
              with(:query => {:apiKey => "api_key", :twitter => "brawtest"}).
              to_return(:body => fixture("person.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            FullContact.person(email:  "brawest@gmail.com")
            a_get("person.#{format}")
          .with(:query => {:apiKey => "api_key", :email => "brawest@gmail.com"})
          .should have_been_made
          end

          it "should return the same results as a client by email" do
            FullContact.person(:email => "brawest@gmail.com").should == FullContact::Client.new.person(:email => "brawest@gmail.com")
          end

          it "should return the same results as a client by twitter" do
            FullContact.person(:twitter => "brawtest").should == FullContact::Client.new.person(:twitter => "brawtest")
          end
        end

        describe "#people" do
          before do
            stub_post("batch.#{format}").
            with(:query => {:apiKey => "api_key"},
                 :body => {"requests"=>["https://api.fullcontact.com/v2/person.#{format}?email=brawest%40gmail.com"]}).
            to_return(:status => 200, :body => fixture("batch.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})

            stub_post("batch.#{format}").
            with(:query => {:apiKey => "api_key"},
                 :body => {"requests"=>[
                   "https://api.fullcontact.com/v2/person.#{format}?email=brawest%40gmail.com",
                   "https://api.fullcontact.com/v2/person.#{format}?q=kyle+hansen",
                   "https://api.fullcontact.com/v2/person.#{format}?twitter=brawtest"
            ]}).
            to_return(:status => 200, :body => fixture("batch.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})

          end

          it "should get the correct resource" do
            FullContact.people([{email:  "brawest@gmail.com"}])
            a_post("batch.#{format}")
          .with(:query => {:apiKey => "api_key"}, :body => {"requests"=>["https://api.fullcontact.com/v2/person.#{format}?email=brawest%40gmail.com"]})
          .should have_been_made
          end

          it "should return multiple results by different means" do
            peeps = FullContact.people([
              {:email => "brawest@gmail.com"},
              {:q => 'kyle hansen'},
              {:twitter => "brawtest"}
            ])

            peeps.size.should == 3
          end

          it "should get the results in batches if over the limit" do
            FullContact.batch_size = 3
            stub_post("batch.#{format}").
            with(:query => {:apiKey => "api_key"},
                 :body => {"requests"=>[
                   "https://api.fullcontact.com/v2/person.#{format}?email=brawest2%40gmail.com",
                   "https://api.fullcontact.com/v2/person.#{format}?q=kyle2+hansen",
                   "https://api.fullcontact.com/v2/person.#{format}?twitter=brawtest2"
            ]}).
            to_return(:status => 200, :body => fixture("batch.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})

            peeps = FullContact.people([
              {:email => "brawest@gmail.com"},
              {:q => 'kyle hansen'},
              {:twitter => "brawtest"},
              {:email => "brawest2@gmail.com"},
              {:q => 'kyle2 hansen'},
              {:twitter => "brawtest2"}
            ])

            peeps.size.should == 6
          end
        end
      end
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

  describe ".batch_size" do
    it "should return the default endpoint" do
      FullContact.batch_size.should == FullContact::Configuration::DEFAULT_BATCH_SIZE
    end
  end

  describe ".batch_size=" do
    it "should set the endpoint" do
      FullContact.batch_size = 4
      FullContact.batch_size.should == 4
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
