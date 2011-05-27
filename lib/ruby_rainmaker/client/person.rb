module RubyRainmaker
  class Client
    module Person
      # Returns extended information for a given email
      #
       def person(email)
        response = get('person', email)
        format.to_s.downcase == 'xml' ? response['user'] : response
      end
  	end
  end
end
