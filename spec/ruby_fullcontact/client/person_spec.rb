require 'helper'

describe FullContact::Client do
  FullContact::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = FullContact::Client.new(:format => format, :api_key => 'api_key')
      end

    end
  end
end
