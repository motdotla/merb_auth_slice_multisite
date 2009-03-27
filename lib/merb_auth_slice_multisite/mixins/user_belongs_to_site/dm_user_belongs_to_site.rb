module Merb
  class Authentication
    module Mixins
      module UserBelongsToSite
        module DMClassMethods
          def self.extended(base)
            base.class_eval do
              # Schema
              property :site_id, Integer
              # Validations
              validates_is_unique :login, :scope => :site_id
              # Relationships/Associations
              belongs_to :site
            end # base.class_eval
          end # self.extended
        end # DMClassMethods
      end # UserBelongsToSite
    end # Mixins
  end # Authentication
  
  class Request
    def first_subdomain
      subdomains.first #subdomains is a request variable array so we take the first array entry
    end #first_subdomain
  end #Request
end #Merb