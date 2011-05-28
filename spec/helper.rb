require 'webmock/rspec'
require 'simplecov'
require 'ruby-rainmaker'
require 'rspec'

SimpleCov.start do
  add_group 'RubyRainmaker', 'lib/ruby_rainmaker'
  add_group 'Faraday Middleware', 'lib/faraday'
  add_group 'Specs', 'spec'
end


RSpec.configure do |config|
  config.include WebMock::API
end

def a_get(path)
  a_request(:get, RubyRainmaker.endpoint + path)
end

def stub_get(path)
  stub_request(:get, RubyRainmaker.endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
