module Faraday
  class Response::Rubyize < Response::Middleware
    def parse(body)
      case body
      when Hash
        body.to_snake_keys
      when Array
        body.map { |item| parse(item) }
      else
        body
      end
    end
  end
end
