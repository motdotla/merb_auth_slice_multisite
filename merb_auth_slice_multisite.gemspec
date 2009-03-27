# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{merb_auth_slice_multisite}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["scottmotte"]
  s.date = %q{2009-03-27}
  s.email = %q{scott@scottmotte.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["README.rdoc", "VERSION.yml", "lib/merb_auth_slice_multisite", "lib/merb_auth_slice_multisite/merbtasks.rb", "lib/merb_auth_slice_multisite/slicetasks.rb", "lib/merb_auth_slice_multisite/spectasks.rb", "lib/merb_auth_slice_multisite.rb", "test/merb_auth_slice_multisite_test.rb", "test/test_helper.rb", "spec/merb_auth_slice_multisite_spec.rb", "spec/requests", "spec/requests/main_spec.rb", "spec/spec_helper.rb", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/scottmotte/merb_auth_slice_multisite}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{add multisite/subdomain functionality to your merb app on top of merb-auth}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
