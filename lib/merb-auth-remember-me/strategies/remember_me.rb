module Merb::Authentication::Strategies
  class RememberMeStrategy < Merb::Authentication::Strategy
    def run!
      if cookies[:auth_token]
        user = Merb::Authentication.user_class.first(
          :conditions => [ "remember_token = ?", cookies[:auth_token] ]
        )
      end  
      user && user.remembered? ? user : nil
    end # run!
  end # RememberMeStrategy
end # Merb::Authentication::Strategies