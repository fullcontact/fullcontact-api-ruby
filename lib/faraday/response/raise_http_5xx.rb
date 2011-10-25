require 'faraday'

# @private
module Faraday
  # @private
  class Response::RaiseHttp5xx < Response::Middleware
    def on_complete(env)
      case env[:status].to_i
      when 500
        raise FullContact::InternalServerError.new(error_message(env, "Internal server error."), env[:response_headers])
      when 502
        raise FullContact::BadGateway.new(error_message(env, "FullContact is down or being upgraded."), env[:response_headers])
      when 503
        raise FullContact::ServiceUnavailable.new(error_message(env, "Service unavailable."), env[:response_headers])
      end
    end

    private

    def error_message(env, body=nil)
      "#{env[:method].to_s.upcase} #{env[:url].to_s}: #{[env[:status].to_s + ':', body].compact.join(' ')} Check http://status.fullcontact.cc/ for updates on the status of the FullContact service."
    end
  end
end
