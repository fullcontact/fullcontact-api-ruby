module RubyRainmaker
  # Wrapper for the Rainmaker REST API

  class Client < API
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'ruby_rainmaker/client/person'

    alias :api_endpoint :endpoint

    include RubyRainmaker::Client::Person
  end
end
