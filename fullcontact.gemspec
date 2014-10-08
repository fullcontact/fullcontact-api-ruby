# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fullcontact/version"

Gem::Specification.new do |s|
  s.add_development_dependency 'maruku', '~> 0.6'
  s.add_development_dependency 'nokogiri', '~> 1.4'
  s.add_development_dependency 'rake', '~> 0.9'
  s.add_development_dependency 'rspec', '~> 2.6'
  s.add_development_dependency 'simplecov', '~> 0.4'
  s.add_development_dependency 'webmock', '~> 1.6'
  s.add_development_dependency 'yard', '~> 0.7'
  s.add_runtime_dependency 'hashie', '>= 2.0'
  s.add_runtime_dependency 'faraday', '~> 0.9.0'
  s.add_runtime_dependency 'faraday_middleware', '>= 0.9'
  s.add_runtime_dependency 'multi_xml', '>= 0.5'
  s.add_runtime_dependency 'rash', '>= 0.4'

  s.author = "FullContact, Inc."
  s.description = %q{A Ruby wrapper for the FullContact API}
  s.email = ['support@fullcontact.com']

  s.post_install_message = ''

  s.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  s.files = `git ls-files`.split("\n")
  s.homepage = 'https://github.com/fullcontact/fullcontact-api-ruby'
  s.name = 'fullcontact'
  s.require_paths = ['lib']
  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  s.summary = %q{Ruby wrapper for the FullContact API}
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = FullContact::VERSION
end
