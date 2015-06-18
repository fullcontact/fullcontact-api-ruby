require 'faraday_middleware'
require 'faraday/request/gateway'
require 'faraday/response/fullcontact_errors'
require 'faraday/response/rubyize'
require 'faraday_middleware/response/mashify'


module FullContact
  # @private
  module Connection
    private

    def connection(raw=false, faraday_options={})
      options = {
          :headers => {'Accept' => "application/#{format}", 'User-Agent' => user_agent},
          :proxy => proxy,
          :ssl => {:verify => false},
          :url => api_endpoint,
      }.merge(faraday_options)

      Faraday.new(options) do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Request::Gateway, gateway if gateway
        builder.use FaradayMiddleware::Mashify unless raw
        builder.use Faraday::Response::Rubyize unless raw or FullContact.skip_rubyize
        unless raw
          case format.to_s.downcase
            when 'json'
              builder.use Faraday::Response::ParseJson
          end
        end
        builder.use Faraday::Response::FullContactErrors
        builder.adapter Faraday.default_adapter
      end
    end
  end
end
