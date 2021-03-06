# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{merb_auth_slice_multisite}
  s.version = "0.8.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["scottmotte"]
  s.date = %q{2009-05-09}
  s.email = %q{scott@scottmotte.com}
  s.files = ["README.textile", "VERSION.yml", "lib/merb-auth-more", "lib/merb-auth-more/strategies", "lib/merb-auth-more/strategies/multisite", "lib/merb-auth-more/strategies/multisite/multisite_password_form.rb", "lib/merb-auth-remember-me", "lib/merb-auth-remember-me/mixins", "lib/merb-auth-remember-me/mixins/authenticated_user", "lib/merb-auth-remember-me/mixins/authenticated_user/dm_authenticated_user.rb", "lib/merb-auth-remember-me/mixins/authenticated_user.rb", "lib/merb-auth-remember-me/strategies", "lib/merb-auth-remember-me/strategies/remember_me.rb", "lib/merb_auth_slice_multisite", "lib/merb_auth_slice_multisite/merbtasks.rb", "lib/merb_auth_slice_multisite/mixins", "lib/merb_auth_slice_multisite/mixins/user_belongs_to_site", "lib/merb_auth_slice_multisite/mixins/user_belongs_to_site/dm_user_belongs_to_site.rb", "lib/merb_auth_slice_multisite/mixins/user_belongs_to_site.rb", "lib/merb_auth_slice_multisite/slicetasks.rb", "lib/merb_auth_slice_multisite/spectasks.rb", "lib/merb_auth_slice_multisite.rb", "spec/mailers", "spec/mailers/send_password_mailer_spec.rb", "spec/mixins", "spec/mixins/authenticated_user_spec.rb", "spec/mixins/user_belongs_to_site_spec.rb", "spec/models", "spec/models/site_spec.rb", "spec/spec_helper.rb", "spec/strategies", "spec/strategies/remember_me_spec.rb", "app/controllers", "app/controllers/application.rb", "app/controllers/exceptions.rb", "app/controllers/passwords.rb", "app/controllers/sessions.rb", "app/helpers", "app/helpers/application_helper.rb", "app/mailers", "app/mailers/send_password_mailer.rb", "app/mailers/views", "app/mailers/views/send_password_mailer", "app/mailers/views/send_password_mailer/send_password.text.erb", "app/models", "app/models/site.rb", "app/views", "app/views/exceptions", "app/views/exceptions/unauthenticated.html.erb", "app/views/layout", "app/views/layout/merb_auth_slice_multisite.html.erb", "config/database.yml", "config/dependencies.rb", "config/init.rb", "config/router.rb", "public/javascripts", "public/javascripts/master.js", "public/stylesheets", "public/stylesheets/master.css", "stubs/app", "stubs/app/controllers", "stubs/app/controllers/sessions.rb", "stubs/app/views", "stubs/app/views/exceptions", "stubs/app/views/exceptions/unauthenticated.html.erb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/scottmotte/merb_auth_slice_multisite}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{add multisite/subdomain functionality to your merb app on top of merb-auth}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
