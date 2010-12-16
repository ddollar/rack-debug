$:.unshift File.expand_path("../lib", __FILE__)
require "rack/debug/version"

Gem::Specification.new do |gem|
  gem.name    = "rack-debug"
  gem.version = Rack::Debug::VERSION

  gem.author   = "David Dollar"
  gem.email    = "ddollar@gmail.com"

  gem.summary     = "A Rack-middleware interface to ruby-debug"
  gem.description = "Rack::Debug is a middleware that provides a simple interface to ruby-debug. Helps debug apps running in Passenger."
  gem.homepage    = "http://github.com/ddollar/rack-debug"

  gem.files = Dir["**/*"].select { |d| d =~ %r{^(README|bin/|data/|ext/|lib/|spec/|test/)} }

  gem.add_dependency "rack",         ">= 1.0"
  gem.add_dependency "ruby-debug19", "~> 0.11.6"

  gem.required_ruby_version = ">= 1.9.2"
end
