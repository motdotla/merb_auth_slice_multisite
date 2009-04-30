require 'merb-auth-more/strategies/abstract_password'
# This strategy uses a login, password, and site_id parameter.
#
# Overwrite the :password_param, :login_param, and :site_id_param
# to return the name of the field (on the form) that you're using the 
# login with.  These can be strings or symbols
#
# == Required
#
# === Methods
# <User>.authenticate(login_param, password_param)
#
class Merb::Authentication
  module Strategies
    module Multisite
      
      # add site_id to base params.
      # http://github.com/wycats/merb/blob/784ac7d71780d1a7cfb9152ba4cb0e
      # 18a990ab7a/merb-auth/merb-auth-more/lib/merb-auth-more/
      # strategies/abstract_password.rb
      class Base < Merb::Authentication::Strategy
        abstract!
        
        # Overwrite this method to customize the field
        def self.password_param
          (Merb::Plugins.config[:"merb-auth"][:password_param] || :password).to_s.to_sym
        end
        
        # Overwrite this method to customize the field
        def self.login_param
          (Merb::Plugins.config[:"merb-auth"][:login_param] || :login).to_s.to_sym
        end
        
        # http://scottmotte.com/archives/194.html
        def self.site_id_param
          (Merb::Plugins.config[:"merb-auth"][:site_id_param] || :site_id).to_s.to_sym
        end
                
        def password_param
          @password_param ||= Base.password_param
        end
        
        def login_param
          @login_param ||= Base.login_param
        end
        
        # http://scottmotte.com/archives/194.html
        def site_id_param
          @site_id_param ||= Base.site_id_param
        end
      end
      
      # custom strategy taking into account site_id and authenticating with it
      # the authenticate method is already well defined so for now I made a muck of
      # if/else statements
      class Form < Base
        
        def run!
          
          if (login = request.params[login_param]) && (password = request.params[password_param]) && (site_id = request.params[site_id_param])
            # see if user exists for the site_id
            user = user_class.first(login_param => login, site_id_param => site_id)
            if user
              # user_class.get(:login)
              user = user_class.authenticate(login, password)
              if !user
                errors = request.session.authentication.errors
                errors.clear!
                errors.add(login_param, strategy_error_message)
              end
              user
            else
              errors = request.session.authentication.errors
              errors.clear!
              errors.add(login_param, strategy_error_message)
            end
            user
          end
        end # run!
        
        def strategy_error_message
          "#{login_param.to_s.capitalize} or #{password_param.to_s.capitalize} were incorrect"
        end
        
      end # Form
    end # Multisite Password
  end # Strategies
end # Authentication