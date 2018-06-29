module FullContact
  class Client
    module Stats
      # Returns extended information of your API account usage for the current month or a previous month
      #
      def stats(options={}, faraday_options={})
        response = get('stats', options, false, faraday_options)
        format.to_s.downcase == 'xml' ? response['response'] : response
      end
    end
  end
end
