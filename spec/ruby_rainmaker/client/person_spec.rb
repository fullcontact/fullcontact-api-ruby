require 'helper'

describe RubyRainmaker::Client do
  RubyRainmaker::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = RubyRainmaker::Client.new(:format => format, :consumer_key => 'CK')
      end

      end
    end
  end