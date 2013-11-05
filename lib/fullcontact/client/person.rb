module FullContact
  class Client
    module Person
      # Returns extended information for a given person (email, phone, twitter or facebook)
      #
       def person(options={}, faraday_options={})
         if options.is_a?(String)
           warn "[DEPRECATION] supplying an email address directly is deprecated.  Please use {email: #{options}} instead."
           options = {:email => options}
         end

         if options.has_key?(:timeoutSeconds)
           options.delete(:timeoutSeconds)
           warn '[DEPRECATION] timeoutSeconds is no longer a supported parameter. It has been removed from your request.'
         end

        response = get('person', options, false, faraday_options)
        format.to_s.downcase == 'xml' ? response['person'] : response
      end
  	end
  end
end
