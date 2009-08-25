# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{after_create}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eli Miller", "Joost Heitbrink", "DeLynn Berry", "Xavier Shay", "Mat Brown"]
  s.date = %q{2009-06-22}
  s.description = %q{A Ruby on Rails plugin to add an after_commit callback}
  s.extra_rdoc_files = [
    "LICENSE",
     "README"
  ]
  s.files = [
    "LICENSE",
     "README",
     "Rakefile",
     "VERSION",
     "lib/after_commit.rb",
     "lib/after_commit/active_record.rb",
     "lib/after_commit/connection_adapters.rb",
     "rails/init.rb",
     "test/after_commit_test.rb"
  ]
  s.homepage = %q{http://github.com/GUI/after_commit}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{A Ruby on Rails plugin to add an after_commit callback}
  s.test_files = [
    "test/after_commit_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
