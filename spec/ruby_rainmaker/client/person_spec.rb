require 'helper'

describe Rainmaker::Client do
  Rainmaker::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Rainmaker::Client.new(:format => format, :api_key => 'api_key')
      end

      end
    end
  end