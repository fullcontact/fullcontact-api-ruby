Rainmaker Ruby Gem
====================
A Ruby wrapper for the [Rainmaker API](http://api.rainmaker.cc) 

Installation
------------
    gem install rainmaker

Documentation
-------------
[http://rdoc.info/gems/rainmaker](http://rdoc.info/gems/rainmaker)

Usage Examples
--------------
    require "rubygems"
    require "rainmaker"

	# This could go in an initializer
	Rainmaker.configure do |config|
		config.api_key = "rainmaker_api_key_goes_here"
	end
	
    # Get information about an email address
    person = Rainmaker.person("brawest@gmail.com")

	# Get person's family_name
	puts person.contact_info.family_name

Copyright
---------
Copyright (c) 2010 Brandon West

See [LICENSE](https://github.com/brandonmwest/rainmaker/blob/master/LICENSE.md) for details.
