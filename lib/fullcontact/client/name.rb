module FullContact
  class Client
    module Name
      def normalizer(options={}, faraday_options={})
        response = get('name/normalizer', options, false, faraday_options)
        format.to_s.downcase == 'xml' ? response['person'] : response
      end
    end
  end
end
