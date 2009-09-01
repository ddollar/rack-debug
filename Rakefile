require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rack-debug"
    gem.summary = %Q{Rack::Debug adds a middlerware interface to ruby-debug}
    gem.description = <<-DESCRIPTION

Rack::Debug adds a middlerware interface to ruby-debug 
http://github.com/github/rack-debug

DESCRIPTION
    gem.email = "<ddollar@gmail.com>"
    gem.homepage = "http://github.com/ddollar/rack-debug"
    gem.authors = ["David Dollar"]

    gem.add_dependency 'rack',       '>= 1.0'
    gem.add_dependency 'ruby-debug', '>= 0.10'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
