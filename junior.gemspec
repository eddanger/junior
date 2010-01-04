# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{junior}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Wood"]
  s.date = %q{2010-01-04}
  s.description = %q{A Mini MVC Web Framework for Ruby built on Rack and a lot of inspiration from Sinatra}
  s.email = %q{mike@michaelwood.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.md",
     "Rakefile",
     "VERSION",
     "junior.gemspec",
     "lib/junior.rb",
     "lib/junior/application.rb",
     "lib/junior/controller.rb",
     "lib/junior/dispatcher.rb",
     "lib/junior/helpers.rb",
     "lib/junior/router.rb",
     "lib/junior/support.rb",
     "spec/junior_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "tasks/spec.rake",
     "tasks/yard.rake"
  ]
  s.homepage = %q{http://github.com/eddanger/junior}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{An MVC Web Framework}
  s.test_files = [
    "spec/junior_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, ["~> 1.1.0"])
      s.add_runtime_dependency(%q<usher>, ["~> 0.6.1"])
      s.add_runtime_dependency(%q<tilt>, ["~> 0.4.0"])
      s.add_development_dependency(%q<rspec>, ["~> 1.2.9"])
      s.add_development_dependency(%q<yard>, ["~> 0.5.2"])
    else
      s.add_dependency(%q<rack>, ["~> 1.1.0"])
      s.add_dependency(%q<usher>, ["~> 0.6.1"])
      s.add_dependency(%q<tilt>, ["~> 0.4.0"])
      s.add_dependency(%q<rspec>, ["~> 1.2.9"])
      s.add_dependency(%q<yard>, ["~> 0.5.2"])
    end
  else
    s.add_dependency(%q<rack>, ["~> 1.1.0"])
    s.add_dependency(%q<usher>, ["~> 0.6.1"])
    s.add_dependency(%q<tilt>, ["~> 0.4.0"])
    s.add_dependency(%q<rspec>, ["~> 1.2.9"])
    s.add_dependency(%q<yard>, ["~> 0.5.2"])
  end
end

