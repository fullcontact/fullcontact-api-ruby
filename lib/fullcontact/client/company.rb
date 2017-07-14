module FullContact
  class Client
    module Company
      # Returns extended information for a given company (email, phone, twitter or facebook)
      #
      def company(options={}, faraday_options={})
        url = "company/lookup"
        if options[:companyName]
          url = "company/search"
        end
        response = get(url, options, false, faraday_options)
        format.to_s.downcase == 'xml' ? response['person'] : response
      end
    end
  end
end
