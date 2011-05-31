module Rainmaker
  # Wrapper for the Rainmaker REST API

  class Client < API
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'rainmaker/client/person'

    alias :api_endpoint :endpoint

    include Rainmaker::Client::Person
  end
end
