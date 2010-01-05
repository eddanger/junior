require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "junior"
    gem.summary = 'An MVC Web Framework'
    gem.description = 'A Mini MVC Web Framework for Ruby built on Rack and a lot of inspiration from Sinatra'
    gem.email = 'mike@michaelwood.com'
    gem.homepage = 'http://github.com/eddanger/junior'
    gem.authors = ["Michael Wood"]

    gem.add_dependency 'rack',       "~> 1.1.0"
    gem.add_dependency 'usher',      "~> 0.6.2"
    gem.add_dependency 'tilt',       "~> 0.4.0"

    gem.add_development_dependency 'rspec', '~> 1.2.9'
    gem.add_development_dependency 'yard',  '~> 0.5.2'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

FileList['tasks/**/*.rake'].each { |task| load task }

task :spec => :check_dependencies

task :default => :spec