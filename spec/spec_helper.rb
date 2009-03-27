require 'rubygems'
require 'merb-core'
require 'merb-slices'
require 'spec'

# Add merb_auth_slice_multisite.rb to the search path
Merb::Plugins.config[:merb_slices][:auto_register] = true
Merb::Plugins.config[:merb_slices][:search_path]   = File.join(File.dirname(__FILE__), '..', 'lib', 'merb_auth_slice_multisite.rb')

# Require merb_auth_slice_multisite.rb explicitly so any dependencies are loaded
require Merb::Plugins.config[:merb_slices][:search_path]

# Using Merb.root below makes sure that the correct root is set for
# - testing standalone, without being installed as a gem and no host application
# - testing from within the host application; its root will be used
Merb.start_environment(
  :testing => true, 
  :adapter => 'runner', 
  :environment => ENV['MERB_ENV'] || 'test',
  :session_store => 'memory'
)

module Merb
  module Test
    module SliceHelper
      
      # The absolute path to the current slice
      def current_slice_root
        @current_slice_root ||= File.expand_path(File.join(File.dirname(__FILE__), '..'))
      end
      
      # Whether the specs are being run from a host application or standalone
      def standalone?
        Merb.root == ::MerbAuthSliceMultisite.root
      end
      
    end
  end
end

Spec::Runner.configure do |config|
  config.include(Merb::Test::ViewHelper)
  config.include(Merb::Test::RouteHelper)
  config.include(Merb::Test::ControllerHelper)
  config.include(Merb::Test::SliceHelper)
  
  config.before(:all) do
    DataMapper.auto_migrate! if Merb.orm == :datamapper
  end
end

# You can add your own helpers here
#
Merb::Test.add_helpers do
  def mount_slice
    Merb::Router.prepare { add_slice(:MerbAuthSliceMultisite, "merb_auth_slice_multisite") } if standalone?
  end

  def dismount_slice
    Merb::Router.reset! if standalone?
  end
end

# =============================================================================
# SITE STUFF
# =============================================================================
def valid_site_attributes(options = {})
  {
    :domain => 'http://www.example.org',
    :subdomain => 'example',
    :id => 1
  }.merge(options)
end

def valid_second_site_attributes(options = {})
  {
    :domain => 'http://www.example2.org',
    :subdomain => 'example2',
    :active => true,
    :id => 2
  }.merge(options)
end

def valid_third_site_attributes(options = {})
  {
    :domain => 'http://www.example3.org',
    :subdomain => 'example3',
    :active => true,
    :id => 3
  }.merge(options)
end

