module Faraday
  class Response::RainmakerErrors < Response::Middleware
      def on_complete(env)
	   case env[:status]
			when 400
			raise Rainmaker::BadRequest.new(error_message(env), env[:response_headers])
		  when 401
			raise Rainmaker::Unauthorized.new(error_message(env), env[:response_headers])
		  when 403
			raise Rainmaker::Forbidden.new(error_message(env), env[:response_headers])
		  when 404
			raise Rainmaker::NotFound.new(error_message(env), env[:response_headers])
		  when 422
			raise Rainmaker::Invalid.new(error_message(env), env[:response_headers])
 		when 500
        raise Rainmaker::InternalServerError.new(error_message(env), env[:response_headers])
      when 502
        raise Rainmaker::BadGateway.new(error_message(env), env[:response_headers])
      when 503
        raise Rainmaker::ServiceUnavailable.new(error_message(env), env[:response_headers])
      end
		   end

	 def error_message(env)
      "#{env[:method].to_s.upcase} #{env[:url].to_s}: #{env[:status]}"
    end

    def initialize(app)
      super
      @parser = nil
    end
  end
end
