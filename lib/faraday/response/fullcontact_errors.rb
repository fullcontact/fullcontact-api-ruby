module Faraday
  class Response::FullContactErrors < Response::Middleware
      def on_complete(env)
	   case env[:status]
			when 400
			raise FullContact::BadRequest.new(error_message(env), env[:response_headers])
		  when 401
			raise FullContact::Unauthorized.new(error_message(env), env[:response_headers])
		  when 403
			raise FullContact::Forbidden.new(error_message(env), env[:response_headers])
		  when 404
			raise FullContact::NotFound.new(error_message(env), env[:response_headers])
		  when 422
			raise FullContact::Invalid.new(error_message(env), env[:response_headers])
 		when 500
        raise FullContact::InternalServerError.new(error_message(env), env[:response_headers])
      when 502
        raise FullContact::BadGateway.new(error_message(env), env[:response_headers])
      when 503
        raise FullContact::ServiceUnavailable.new(error_message(env), env[:response_headers])
      end
		   end

      def error_message(env)
        msg = JSON.parse(env[:body])['message'] if env[:body]
        "#{env[:method].to_s.upcase} #{env[:status]} #{env[:url].to_s}: #{msg}"
      end

    def initialize(app)
      super
      @parser = nil
    end
  end
end
