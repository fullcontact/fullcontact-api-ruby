FullContact Ruby Gem
====================
A Ruby wrapper for the [FullContact API](http://www.fullcontact.com/)

[![Build Status](https://travis-ci.org/fullcontact/fullcontact-api-ruby.svg?branch=master)](https://travis-ci.org/fullcontact/fullcontact-api-ruby)
[![Gem Version](https://badge.fury.io/rb/fullcontact.svg)](http://badge.fury.io/rb/fullcontact)
[![Code Climate](https://codeclimate.com/github/fullcontact/fullcontact-api-ruby/badges/gpa.svg)](https://codeclimate.com/github/fullcontact/fullcontact-api-ruby)
[![Test Coverage](https://codeclimate.com/github/fullcontact/fullcontact-api-ruby/badges/coverage.svg)](https://codeclimate.com/github/fullcontact/fullcontact-api-ruby)

Changes
-------
- 0.13.0
    - Raise `ArgumentError` if query by Facebook ID/username is used.
    - Remove deprecated messages.
- 0.12.0 - `include_headers_in_response = true` includes response headers in returned payload
 - Accessible as `http_headers` in response. Also accessible on thrown errors (e.g. RateLimited)
- 0.11.0 - Plisskin transformation can be disabled by specifying a `skip_rubyize = true` in config block.
- 0.10.0 - Support for FullContact Company API
- 0.9.0 - Removed Rash gem and replaced with Mashify + Plisskin
- 0.8.2 - Fix for 0.8.0 constant resolution issue.
- 0.8.0
    - Hashie now allowed from [2.2, 4.0) to support a wide range of other applications
    - Default useragent includes version number for our own information
    - Useless XML mode and dep on `multi_xml` removed
    - Code reformatting & basic code hygiene, prep for new features in 0.9.0
- 0.7.0 - Faraday 0.9.0
- 0.6.0 - Removal of timeoutSeconds parameter. This parameter is automatically stripped from your request if included.

Installation
------------
    gem install fullcontact

Documentation
-------------
[http://rdoc.info/gems/fullcontact](http://rdoc.info/gems/fullcontact)

Usage Examples
--------------
```ruby
    require 'fullcontact'

    # This could go in an initializer
    FullContact.configure do |config|
        config.api_key = 'fullcontact_api_key_goes_here'
    end
	
    # Get information about an email address
    person = FullContact.person(email: 'bart@fullcontact.com')
```
All returned values are Hashie structs. You can access fields as if they were fields:

```ruby
    # Get person's family_name
    person.contact_info.family_name
     => "Lorang"
```

But you can also turn it into a normal hash

```ruby
    # Get person's family_name
    person.to_hash['contact_info']['family_name']
     => "Lorang"
```

There's other ways you can query the Person API:
```ruby
    # Get information about an email address, organized by hashes vs. lists
    person2 = FullContact.person(email: 'bart@fullcontact.com', style: 'dictionary')
    
    # You can pass in any arbitrary parameters the Person API supports
    person3 = FullContact.person(email: 'bart@fullcontact.com', style: 'dictionary', webhookUrl: 'https://...')
    
    # Get information about a twitter handle
    person4 = FullContact.person(twitter: "bartlorang")
    
    # Get information from a phone number
    person6 = FullContact.person(phone:13037170414)
    
    # Get information about a twitter and ensure a 30s socket open timeout and a 15s socket read timeout
    # Can throw a Faraday::Error::TimeoutError if timeouts are exceeded
    person7 = FullContact.person({:twitter => "bartlorang"}, {:request => {:timeout => 15, :open_timeout => 30}})

```

Response formats can more closely mirror FullContact's APIs by disabling snake_case transformation:
```ruby
    FullContact.configure do |config|
        config.api_key = "fullcontact_api_key_goes_here"
        config.skip_rubyize = true
    end

    person8 = FullContact.person(email: "bart@fullcontact.com")

    => #<Hashie::Mash contactInfo=#<Hashie::Mash chats=[#<Hashie::Mash client="gtalk" handle="lorangb@gmail.com">, 
    #<Hashie::Mash client="skype" handle="bart.lorang">] familyName="Lorang" fullName="Bart Lorang" givenName="Bart...
```

You can also query the Company API
```ruby
    # Get information about a company
    company1 = FullContact.company(domain: 'fullcontact.com')

    company1.organization.name
     => "FullContact Inc."
```

	
Contributions
-------------
A full list of contributors can be found in
[GitHub](https://github.com/fullcontact/fullcontact-api-ruby/graphs/contributors)

License
---------
Copyright (c) 2016 FullContact Inc. and contributors



See [LICENSE](https://github.com/fullcontact/fullcontact-api-ruby/blob/master/LICENSE.md) for details.
