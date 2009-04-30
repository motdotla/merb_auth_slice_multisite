require File.dirname(__FILE__) + '/../spec_helper'
 
describe "SendPasswordMailer" do
 
  before(:all) do
    Merb::Router.prepare { add_slice(:merb_auth_slice_password_reset)}
    User.auto_migrate!
  end
 
  after(:all) do
    Merb::Router.reset!
  end
 
  describe MerbAuthSliceMultisite::SendPasswordMailer do
 
    def deliver(action, mail_opts= {},opts = {})
      MerbAuthSliceMultisite::SendPasswordMailer.dispatch_and_deliver action, mail_opts, opts
      @last_delivered_mail = Merb::Mailer.deliveries.last
    end
 
    before(:each) do
      Merb::Mailer.deliveries.clear
      Site.all.destroy!
      User.all.destroy!
      @site = Site.create(valid_site_attributes)
      @user = @site.users.build(:email => "homer@simpsons.com", :login => "homer", :password => "donuts" )
      @mailer_params = { :from => "info@mysite.com", :to => @user.email, :subject => "Welcome to MySite.com" }
    end
    
    it "should send mail to homer@simpsons.com for the send password email" do
      deliver(:send_password, @mailer_params, :user => @user)
      @last_delivered_mail.assigns(:headers).should include("to: homer@simpsons.com")
    end
 
    it "should send the mail from 'info@mysite.com' for the the send password email" do
      deliver(:send_password, @mailer_params, :user => @user)
      @last_delivered_mail.assigns(:headers).should include("from: info@mysite.com")
    end
 
    it "should have the link to the subdomain site" do
      deliver(:send_password, @mailer_params, :user => @user)
      @last_delivered_mail.text.should include("http://#{@user.site.subdomain}.#{Merb::Slices::config[:merb_auth_slice_multisite][:domain] = "example.com"}")
    end
 
  end
 
end