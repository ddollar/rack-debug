
spec = Gem::Specification.new do |s|

  s.name        = "rack-debug"
  s.version     = "1.0.2"
  s.summary     = "Rack::Debug adds a middlerware interface to ruby-debug"
  s.homepage    = "http://github.com/ddollar/rack-debug"

  s.description = <<-DESCRIPTION

Rack::Debug adds a middlerware interface to ruby-debug 
http://github.com/github/rack-debug


  DESCRIPTION

  s.author   = "David Dollar"
  s.email    = "ddollar@gmail.com"

  s.files    = ["lib/rack","lib/rack/debug.rb"]
  s.platform = Gem::Platform::RUBY

  s.rubyforge_project = "rack-debug"
  s.require_path      = "lib"
  s.has_rdoc          = true
  s.extra_rdoc_files  = ["README.rdoc"]

end
