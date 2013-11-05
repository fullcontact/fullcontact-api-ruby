module FullContact
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options={}, raw=false, faraday_options={})
      request(:get, path, options, raw, faraday_options)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, raw=false, faraday_options={})
      options[:apiKey] = FullContact.options[:api_key]

      response = connection(raw, faraday_options).send(method) do |request|
        request.url(formatted_path(path), options)
          end

      raw ? response : response.body
    end

    def formatted_path(path)
      [path, format].compact.join('.')
    end
  end
end
