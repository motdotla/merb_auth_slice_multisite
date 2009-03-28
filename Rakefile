require 'rubygems'
require 'rake'
require 'rake/gempackagetask'
require 'spec/rake/spectask'
require 'merb-core'
require 'merb-core/tasks/merb'
require 'merb-core/test/tasks/spectasks'


begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "merb_auth_slice_multisite"
    gem.summary = %Q{add multisite/subdomain functionality to your merb app on top of merb-auth}
    gem.email = "scott@scottmotte.com"
    gem.homepage = "http://github.com/scottmotte/merb_auth_slice_multisite"
    gem.authors = ["scottmotte"]

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = false
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "merb_auth_slice_multisite #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


desc 'Default: run spec examples'
task :default => 'spec'