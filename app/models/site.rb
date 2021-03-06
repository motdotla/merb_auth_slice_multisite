class Site
  include DataMapper::Resource
  include DataMapper::Timestamp
  
  # Schema
  property :id, Serial
  property :subdomain, String, :nullable => :false, :length => (1..40), :unique => true, :format => /^[a-zA-Z0-9\-]*?$/
  property :created_at, DateTime
  property :updated_at, DateTime
  
  # Relationships/Associates
  has n, :users, :order => [:login.asc]
  
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
  
end
