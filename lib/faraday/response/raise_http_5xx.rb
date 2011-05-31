require 'faraday'

# @private
module Faraday
  # @private
  class Response::RaiseHttp5xx < Response::Middleware
    def on_complete(env)
      case env[:status].to_i
      when 500
        raise Rainmaker::InternalServerError.new(error_message(env, "Internal server error."), env[:response_headers])
      when 502
        raise Rainmaker::BadGateway.new(error_message(env, "Rainmaker is down or being upgraded."), env[:response_headers])
      when 503
        raise Rainmaker::ServiceUnavailable.new(error_message(env, "Service unavailable."), env[:response_headers])
      end
    end

    private

    def error_message(env, body=nil)
      "#{env[:method].to_s.upcase} #{env[:url].to_s}: #{[env[:status].to_s + ':', body].compact.join(' ')} Check http://api.rainmaker.cc/ for updates on the status of the Rainmaker service."
    end
  end
end
