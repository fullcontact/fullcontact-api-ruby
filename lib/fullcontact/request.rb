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
      if FullContact.options[:auth_type] == :query
        options[:apiKey] = FullContact.options[:api_key]
      end

      response = connection(raw, faraday_options).send(method) do |request|
        request.url(formatted_path(path), options)

        if FullContact.options[:auth_type] == :header
          request.headers[FullContact::Configuration::AUTH_HEADER_NAME] = FullContact.options[:api_key]
        end
      end

      raw ? response : response.body
    end

    def formatted_path(path)
      [path, format].compact.join('.')
    end
  end
end
