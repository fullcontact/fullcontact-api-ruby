require "faraday"
require "faraday_middleware"
require 'rainmaker/error'
require 'rainmaker/configuration'
require 'rainmaker/api'
require 'rainmaker/client'

module Rainmaker
  extend Configuration

  # Alias for Rainmaker::Client.new
  #
  # @return [Rainmaker::Client]
  def self.client(options={})
    Rainmaker::Client.new(options)
  end

  # Delegate to Rainmaker::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method, include_private = false)
    client.respond_to?(method, include_private) || super(method, include_private)
  end
end