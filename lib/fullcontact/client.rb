module FullContact
  # Wrapper for the FullContact REST API

  class Client < API
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'fullcontact/client/person'

    alias :api_endpoint :endpoint

    include FullContact::Client::Person
  end
end
