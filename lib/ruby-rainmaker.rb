require "faraday"
require "faraday_middleware"
require 'ruby_rainmaker/error'
require 'ruby_rainmaker/configuration'
require 'ruby_rainmaker/api'
require 'ruby_rainmaker/client'

module RubyRainmaker
  extend Configuration

  # Alias for RubyRainmaker::Client.new
  #
  # @return [RubyRainmaker::Client]
  def self.client(options={})
    RubyRainmaker::Client.new(options)
  end

  # Delegate to RubyRainmaker::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method, include_private = false)
    client.respond_to?(method, include_private) || super(method, include_private)
  end
end