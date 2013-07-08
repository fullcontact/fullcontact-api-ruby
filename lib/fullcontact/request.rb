module FullContact
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options={}, raw=false, faraday_options={})
      options[:apiKey] = FullContact.options[:api_key]
      response = connection(raw, faraday_options).get do |req|
        req.url(formatted_path(path), options)
      end
      raw ? response : response.body
    end

    def post(path, options={}, raw=false, faraday_options={})
      response = connection(raw, faraday_options).post do |req|
        req.url(formatted_path(path), {:apiKey =>  FullContact.options[:api_key]})
        req.body = options
      end
      raw ? response : response.body
    end

    private

    def formatted_path(path)
      [path, format].compact.join('.')
    end
  end
end
