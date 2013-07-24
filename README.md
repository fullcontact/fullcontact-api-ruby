FullContact Ruby Gem
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
	
    # Get information about a email address
    person = FullContact.person(email: "brawest@gmail.com")
    
    # Get information about a twitter handle
    person2 = FullContact.person(twitter: "brawest")

    # Get information about a facebook username
    person3 = FullContact.person(facebookUsername: "bart.lorang")
    
    # Get information from a phone number
    person4 = FullContact.person(phone:13037170414)
    
    # Get information about a twitter and ensure a 30s socket open timeout and a 15s socket read timeout
    # Can throw a Faraday::Error::TimeoutError if timeouts are exceeded
    person3 = FullContact.person({:twitter => "brawest"}, {:request => {:timeout => 15, :open_timeout => 30}})

	# Get person's family_name
	puts person.contact_info.family_name
	
Contributions
-------------
- Michael Rose (Xorlev)
- Ian Fisher (i-taptera)
- Scott Watermasysk (scottwater)

Copyright
---------
Copyright (c) 2012 FullContact, Brandon West

See [LICENSE](https://github.com/brandonmwest/rainmaker/blob/master/LICENSE.md) for details.
