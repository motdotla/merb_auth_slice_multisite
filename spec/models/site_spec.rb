require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Site do

  before(:each) do
    Site.all.destroy!
    @site = Site.new(valid_site_attributes)
  end
  
  it "should be valid when new" do
    @site.should be_valid
  end

  it "should be invalid when domain is not unique" do
    @site.save
    @site.should be_valid
    
    @site2 = Site.new(valid_site_attributes)
    @site2.subdomain = "differentsubdomain"
    @site2.save
    @site2.should_not be_valid
  end
  
  it "should be invalid when subdomain is not unique" do
    @site.save
    @site.should be_valid
    
    @site2 = Site.new(valid_site_attributes)
    @site2.domain = "http://differenturl.com"
    @site2.save
    @site2.should_not be_valid
  end
  
  it "should not allow use of reserved subdomains" do
    Site::ReservedSubdomains.each do |reserved|
      @site.subdomain = reserved
      @site.save
      @site.should_not be_valid
    end
  end
  
  it "should be invalid if missing a domain extension" do
    @site.save
    @site.domain.should match(/(\.[a-z]{2,4})$/)
    
    @site2 = Site.new(valid_site_attributes)
    @site2.domain = "secondmemorial.com"
    @site2.save
    @site2.domain.should match(/(\.[a-z]{2,4})$/)
  end
  
  it "should only allow text and numbers as a subdomain and should not allow any odd characters or whitespace" do
    @site.save
    @site.subdomain.should match(/^[a-zA-Z0-9\-]*?$/)
    
    @site2 = Site.new(valid_site_attributes)
    @site2.subdomain = "strange-but-legal"
    @site2.save
    @site2.subdomain.should match(/^[a-zA-Z0-9\-]*?$/)
    
    @site3 = Site.new(valid_site_attributes)
    @site3.subdomain = "i!!egal@ch@racters"
    @site3.save
    @site3.subdomain.should_not match(/^[a-zA-Z0-9\-]*?$/)
  end
  
  it "should clean http:// and www from the domain" do
    @site.save
    @site.domain.should_not include("http://")
    @site.domain.should_not include("www.")
  end
    
  it "should respond to users" do
    pending
    @site.save
    @site.should respond_to(:users)
  end
  
end