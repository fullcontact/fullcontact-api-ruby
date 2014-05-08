module FullContact
  class Client
    module CardReader
      # Returns extended information for a given person (email, phone, twitter or facebook)
      #
       def card_reader(options={}, faraday_options={})
        response = get('cardReader', options, false, faraday_options)
        format.to_s.downcase == 'xml' ? response['response'] : response
      end

  	end
  end
end
