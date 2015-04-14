module FullContact
  class Client
    module Company
      # Returns extended information for a given person (email, phone, twitter or facebook)
      #
      def company(options={}, faraday_options={})
        response = get('company/lookup', options, false, faraday_options)
        format.to_s.downcase == 'xml' ? response['person'] : response
      end
    end
  end
end
