Rainmaker Ruby Gem
====================
A Ruby wrapper for the [FullContact API](http://www.fullcontact.com/)

Installation
------------
    gem install fullcontact

Documentation
-------------
[http://rdoc.info/gems/fullcontact](http://rdoc.info/gems/fullcontact)

Usage Examples
--------------
    require "rubygems"
    require "fullcontact"

	# This could go in an initializer
	FullContact.configure do |config|
		config.api_key = "fullcontact_api_key_goes_here"
	end
	
    # Get information about an email address
    person = FullContact.person("brawest@gmail.com")

	# Get person's family_name
	puts person.contact_info.family_name

Copyright
---------
Copyright (c) 2011 Brandon West

See [LICENSE](https://github.com/brandonmwest/rainmaker/blob/master/LICENSE.md) for details.
