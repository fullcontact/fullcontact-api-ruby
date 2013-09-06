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
        response = get('person', options, false, faraday_options)
        format.to_s.downcase == 'xml' ? response['person'] : response
      end

      #TODO: Threading or some sort of parralizing for multiple requests....
      def people(options=[],faraday_options={})
        warn "You are fetching more than 20 people, multiple requests will be made" if options.size > 20

        c = connection(false, faraday_options)
        options.each_slice(FullContact.batch_size).to_a.map do |options_of_twenty|
          batch_endpoints = options_of_twenty.map do |option|
            c.build_url(formatted_path('person'), option).to_s.downcase
          end
          response = post('batch', {:requests => batch_endpoints}, false, faraday_options)
          res = if format.to_s.downcase == 'xml'
            response['batch']['responses'].map{|k,v| v }.first
          else
            response['responses'].map{ |k,v| v.request_url = k; v }
          end
          batch_endpoints.map do |endpoint_url|
            if index = res.index{|r| r.request_url == endpoint_url}
              res[index]
            else
              Hashie::Rash.new({:message => 'could not map the request url to a response'})
            end
          end
        end.flatten
      end
  	end
  end
end
