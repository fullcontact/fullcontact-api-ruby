module FullContact
  class Client
    module Person
      # Returns extended information for a given email
      #
       def person(email)
        response = get('person', :email => email)
        format.to_s.downcase == 'xml' ? response['person'] : response
      end
  	end
  end
end
