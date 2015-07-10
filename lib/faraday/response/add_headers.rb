module Faraday
  class Response::AddHeaders < Response::Middleware
    def on_complete(env)
      env.body[:http_headers] = env.response_headers
      env.body
    end
  end
end
