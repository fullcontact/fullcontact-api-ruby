module FullContact
  class Client
    module Person
      # Returns extended information for a given person (email, phone, twitter or facebook)
      #
      def person(options={}, faraday_options={})
        if options.is_a?(String)
          raise ArgumentError, "Supplying an email address directly is not supported. Please use {email: #{options}} instead."
        end

        if options.has_key?(:facebookUsername) || options.has_key?(:facebookId)
          raise ArgumentError, "Querying by Facebook ID or username is no longer supported. Please contact support@fullcontact.com for more information."
        end

        response = get('person', options, false, faraday_options)
        format.to_s.downcase == 'xml' ? response['person'] : response
      end
    end
  end
end
