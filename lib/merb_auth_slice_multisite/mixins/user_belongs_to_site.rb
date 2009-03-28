module Merb
  class Authentication
    module Mixins
      # This mixin provides basic user authentication by a site_id.
      #
      # Added properties:
      #  :site_id, Integer
      #
      # Added Relationships
      #  belongs_to :site
      #
      # Added Validations
      #  validates_present :site_id
      #  validates_is_unique :login, :scope => :site_id
      #  validates_is_unique :email, :scope => :site_id
      #
      # To use it simply require it and include it into your user class.
      #
      # class User
      #   include Authentication::Mixins::UserBelongsToSite
      #
      # end
      #
      #
      # OR I RECOMMEND recommend that you put it in your application under merb/merb-auth/setup.rb so it looks like this:
      # # require 'merb-auth-more/mixins/salted_user'
      # # Merb::Authentication.user_class.class_eval{ 
      # #  include Merb::Authentication::Mixins::SaltedUser
      # #  include Merb::Authentication::Mixins::UserBelongsToSite
      # # }
      #
      module UserBelongsToSite
        def self.included(base)
          base.class_eval do
            include Merb::Authentication::Mixins::UserBelongsToSite::InstanceMethods
            extend  Merb::Authentication::Mixins::UserBelongsToSite::ClassMethods

            path = File.expand_path(File.dirname(__FILE__)) / "user_belongs_to_site"
            if defined?(DataMapper) && DataMapper::Resource > self
              require path / "dm_user_belongs_to_site"
              extend(Merb::Authentication::Mixins::UserBelongsToSite::DMClassMethods)
            elsif defined?(ActiveRecord) && ancestors.include?(ActiveRecord::Base)
              require path / "ar_user_belongs_to_site"
              extend(Merb::Authentication::Mixins::UserBelongsToSite::ARClassMethods)
            elsif defined?(Sequel) && ancestors.include?(Sequel::Model)
              require path / "sq_user_belongs_to_site"
              extend(Merb::Authentication::Mixins::UserBelongsToSite::SQClassMethods)
            end

          end # base.class_eval
        end # self.included
        
        module ClassMethods
          # 
        end # ClassMethods
        
        module InstanceMethods
          # 
        end # InstanceMethods
      end # UserBelongsToSite
    end # Mixins
  end # Authentication
end # Merb