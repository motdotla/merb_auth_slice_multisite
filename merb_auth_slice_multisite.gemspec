# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{merb_auth_slice_multisite}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["scottmotte"]
  s.date = %q{2009-03-27}
  s.email = %q{scott@scottmotte.com}
  s.executables = ["autospec", "autotest", "common.rb", "edit_json.rb", "erubis", "merb", "multigem", "multiruby", "multiruby_setup", "parse_tree_abc", "parse_tree_audit", "parse_tree_deps", "parse_tree_show", "r2r_show", "rackup", "rake", "rake2thor", "slice", "spec", "thor", "unit_diff", "zentest"]
  s.extra_rdoc_files = ["README.textile", "LICENSE"]
  s.files = ["README.textile", "VERSION.yml", "bin/autospec", "bin/autotest", "bin/common.rb", "bin/edit_json.rb", "bin/erubis", "bin/merb", "bin/multigem", "bin/multiruby", "bin/multiruby_setup", "bin/parse_tree_abc", "bin/parse_tree_audit", "bin/parse_tree_deps", "bin/parse_tree_show", "bin/r2r_show", "bin/rackup", "bin/rake", "bin/rake2thor", "bin/slice", "bin/spec", "bin/thor", "bin/unit_diff", "bin/zentest", "lib/merb_auth_slice_multisite", "lib/merb_auth_slice_multisite/merbtasks.rb", "lib/merb_auth_slice_multisite/mixins", "lib/merb_auth_slice_multisite/mixins/user_belongs_to_site", "lib/merb_auth_slice_multisite/mixins/user_belongs_to_site/dm_user_belongs_to_site.rb", "lib/merb_auth_slice_multisite/mixins/user_belongs_to_site.rb", "lib/merb_auth_slice_multisite/slicetasks.rb", "lib/merb_auth_slice_multisite/spectasks.rb", "lib/merb_auth_slice_multisite.rb", "spec/merb_auth_slice_multisite_spec.rb", "spec/mixins", "spec/mixins/user_belongs_to_site_spec.rb", "spec/models", "spec/models/site_spec.rb", "spec/requests", "spec/spec_helper.rb", "LICENSE"]
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
