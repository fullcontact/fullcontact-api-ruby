module FullContact
  class Client
    module Stats
      # Returns stats for a given user accout
      #
      def stats(options={}, faraday_options={})
        url = "stats"
        response = get(url, options, false, faraday_options)
        format.to_s.downcase == 'xml' ? response['response'] : response
      end
    end
  end
end
