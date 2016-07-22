require 'faraday'
require 'fullcontact/version'

module FullContact
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {FullContact::API}
    VALID_OPTIONS_KEYS = [
        :adapter,
        :api_key,
        :auth_type,
        :endpoint,
        :format,
        :skip_rubyize,
        :include_headers_in_response,
        :gateway,
        :proxy,
        :user_agent].freeze

    # An array of valid request/response formats
    VALID_FORMATS = [:json].freeze

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, don't set an application key
    DEFAULT_API_KEY = nil

    # By default, use query parameters
    DEFAULT_AUTH_TYPE = :query

    # The endpoint that will be used to connect if none is set
    #
    DEFAULT_ENDPOINT = 'https://api.fullcontact.com/v2/'.freeze

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is preferred over XML because it is more concise and faster to parse.
    DEFAULT_FORMAT = :json

    # Default transformation done to response
    DEFAULT_SKIP_RUBYIZE = false

    # Includes response headers
    DEFAULT_INCLUDE_HEADERS_IN_RESPONSE = false

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "FullContact Ruby Client/#{FullContact::VERSION}".freeze

    DEFAULT_GATEWAY = nil

    AUTH_HEADER_NAME = 'X-FullContact-APIKey'.freeze

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each { |k| options[k] = send(k) }
      options
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter = DEFAULT_ADAPTER
      self.api_key = DEFAULT_API_KEY
      self.auth_type = DEFAULT_AUTH_TYPE
      self.endpoint = DEFAULT_ENDPOINT
      self.format = DEFAULT_FORMAT
      self.skip_rubyize = DEFAULT_SKIP_RUBYIZE
      self.include_headers_in_response = DEFAULT_INCLUDE_HEADERS_IN_RESPONSE
      self.proxy = DEFAULT_PROXY
      self.user_agent = DEFAULT_USER_AGENT
      self.gateway = DEFAULT_GATEWAY
      self
    end
  end
end
