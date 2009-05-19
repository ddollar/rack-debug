require 'rubygems'
require 'erb'
require 'yaml'
require 'rake'

begin
  require 'hanna/rdoctask'
rescue LoadError
  require 'rake/rdoctask'
end

namespace :gem do

  task :config do
    @config = OpenStruct.new

    File.open("config/gem.rb", "r") do |gem_config|
      eval(gem_config.read)
    end

    @config.files = FileList["{bin,doc,lib,test}/**/*"].to_a.map do |file|
      '"' + file + '"'
    end.join(',')
  end

  desc "Build the gem"
  task :build => [ 'gem:config', 'gem:spec:build' ] do
    spec = nil
    File.open("#{@config.name}.gemspec", 'r') do |gemspec|
      eval gemspec.read
    end
    gemfile = Gem::Builder.new(spec).build
    Dir.mkdir('pkg') unless File.exists?('pkg')
    File.rename(gemfile, "pkg/#{gemfile}")
  end

  namespace :spec do

    desc "Build gemspec"
    task :build => [ :config ] do
      File.open("config/gemspec.rb.erb", "r") do |template|
        File.open("#{@config.name}.gemspec", "w") do |gemspec|
          template_data =  "<% config = YAML::load(%{#{Regexp.escape(YAML::dump(@config))}}) %>\n"
          template_data += template.read
          original_stdout = $stdout
          $stdout = gemspec
          ERB.new(template_data).run
          $stdout = original_stdout
        end
      end
    end

    desc "Test gemspec against Github"
    task :test => [ 'gem:config', :build ] do
      require 'rubygems/specification'
      data = File.read("#{@config.name}.gemspec")
      spec = nil
      Thread.new { spec = eval("$SAFE = 3\n#{data}") }.join
      puts spec
    end

  end
end

namespace :rdoc do

  desc 'Generate RDoc'
  rd = Rake::RDocTask.new(:build) do |rdoc|
    Rake::Task['gem:config'].invoke
    rdoc.title = @config.name
    rdoc.main  = 'README.rdoc'
    rdoc.rdoc_dir = 'doc'
    rdoc.options << '--line-numbers' << '--inline-source'
    rdoc.rdoc_files.include('README.rdoc', 'lib/**/*.rb')
  end

  desc 'View RDoc'
  task :view => [ :build ] do
    system %{open doc/index.html}
  end

end
