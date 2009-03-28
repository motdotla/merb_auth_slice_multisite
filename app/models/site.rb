class Site
  include DataMapper::Resource
  
  # Schema
  property :id, Serial
  property :domain, String, :nullable => :false, :length => (1..40), :unique => true, :format => /(\.[a-z]{2,4})$/
  property :subdomain, String, :nullable => :false, :length => (1..40), :unique => true, :format => /^[a-zA-Z0-9\-]*?$/
  
  # Relationships/Associates
  has n, :users, :order => [:login.asc] # put this in your own site.rb model
  
  # Validations
  validates_with_method :check_subdomain
  
  ReservedSubdomains = %w[backstage admin blog dev ftp mail email pop pop3 imap smtp stage stats status www]
  def check_subdomain
    if ReservedSubdomains.include?(self.subdomain)
      [false, "Subdomain '#{self.subdomain}' is reserved."]
    else
      true
    end
  end
  
  # Hooks
  before :valid?, :remove_http_and_www
  def remove_http_and_www
    if domain
      domain.gsub!('http://', '')
      domain.gsub!('www.', '')
    end
  end
  
end
