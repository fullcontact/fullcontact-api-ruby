require "faraday"
require "faraday_middleware"
require 'fullcontact/error'
require 'fullcontact/configuration'
require 'fullcontact/api'
require 'fullcontact/client'

module FullContact
  extend Configuration

  # Alias for FullContact::Client.new
  #
  # @return [FullContact::Client]
  def self.client(options={})
    FullContact::Client.new(options)
  end

  # Delegate to FullContact::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method, include_private = false)
    client.respond_to?(method, include_private) || super(method, include_private)
  end
end
