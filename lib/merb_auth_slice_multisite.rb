if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  dependency 'merb-mailer'
  dependency 'merb-slices', :immediate => true
  dependency 'merb-auth-core'
  dependency 'merb-auth-more'
  require(File.expand_path(File.dirname(__FILE__) / "merb_auth_slice_multisite" / "mixins") / "user_belongs_to_site")
  require(File.expand_path(File.dirname(__FILE__) / "merb-auth-remember-me" / "mixins") / "authenticated_user")
  
  Merb::Plugins.add_rakefiles "merb_auth_slice_multisite/merbtasks", "merb_auth_slice_multisite/slicetasks", "merb_auth_slice_multisite/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)
  
  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :merb_auth_slice_multisite
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:merb_auth_slice_multisite][:layout] ||= :application
  
  # All Slice code is expected to be namespaced inside a module
  module MerbAuthSliceMultisite
    
    # Slice metadata
    self.description = "see gem description"
    self.version = "see gem version"
    self.author = "see gem authors"
    
    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
    end
    
    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
      require 'merb-auth-more/mixins/redirect_back'      
      unless MerbAuthSliceMultisite[:no_default_strategies]
        # Register the custom strategy so that this slice may utilize it
        # from http://github.com/wycats/merb/blob/784ac7d71780d1a7cfb9152ba4cb0
        # e18a990ab7a/merb-auth/merb-auth-more/lib/merb-auth-more.rb
        merb_auth_more_path = File.expand_path(File.dirname(__FILE__)) / "merb-auth-more" / "strategies" / "multisite"
        merb_auth_remember_me_path = File.expand_path(File.dirname(__FILE__)) / "merb-auth-remember-me" / "strategies"
        Merb::Authentication.register(:multisite_password_form, merb_auth_more_path / "multisite_password_form.rb")
        Merb::Authentication.register(:remember_me, merb_auth_remember_me_path / "remember_me.rb")
        # activate the strategies
        ::Merb::Authentication.activate!(:multisite_password_form)
        ::Merb::Authentication.activate!(:remember_me)
        
        Merb::Authentication.after_authentication do |user,request,params|
          if params[:remember_me] == "1" 
            user.remember_me
            request.cookies.set_cookie(
              :auth_token, 
              user.remember_token, 
              :expires => user.remember_token_expires_at.to_time
            )
          end
          user 
        end # Merb::Authentication.after_authentication
      end
    end
    
    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end
    
    # Deactivation hook - triggered by Merb::Slices.deactivate(MerbAuthSliceMultisite)
    def self.deactivate
    end
    
    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :merb_auth_slice_multisite_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      scope.match("/send_password", :method => :post).to(:controller => "passwords", :action => "send_password").name(:send_password)
      scope.match("/login", :method => :get ).to(:controller => "/exceptions", :action => "unauthenticated").name(:login)
      scope.match("/login", :method => :put ).to(:controller => "sessions", :action => "update").name(:perform_login)
      scope.match("/logout").to(:controller => "sessions", :action => "destroy").name(:logout)
    end
    
  end
  
  # Setup the slice layout for MerbAuthSliceMultisite
  #
  # Use MerbAuthSliceMultisite.push_path and MerbAuthSliceMultisite.push_app_path
  # to set paths to merb_auth_slice_multisite-level and app-level paths. Example:
  #
  # MerbAuthSliceMultisite.push_path(:application, MerbAuthSliceMultisite.root)
  # MerbAuthSliceMultisite.push_app_path(:application, Merb.root / 'slices' / 'merb_auth_slice_multisite')
  # ...
  #
  # Any component path that hasn't been set will default to MerbAuthSliceMultisite.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  MerbAuthSliceMultisite.setup_default_structure!
  
  # Add dependencies for other MerbAuthSliceMultisite classes below. Example:
  # dependency "merb_auth_slice_multisite/other"
  
end