require File.dirname(__FILE__) + '/../spec_helper'

describe "User Belongs To Site" do
  before(:all) do
    Merb::Router.prepare { add_slice(:merb_auth_slice_multisite)}
  end

  after(:all) do
    Merb::Router.reset!
  end

  describe "UserBelongsToSite Mixin" do

    before(:all) do
      User.auto_migrate!
    end

    before(:each) do
      User.all.destroy!
      @user = User.new(valid_user_attributes)
    end

    it "should add the 'site_id' property to the user model" do
      @user.should respond_to(:site_id)
      # @user.should respond_to(:activated_at=)
    end
    
    # 
    # it "should add the 'activation_code' property to the user model" do
    #   @user.should respond_to(:activation_code)
    #   @user.should respond_to(:activation_code=)
    # end
    # 
    # it "should mark all new users as not activated" do
    #   @user.activated?.should == false
    # end
    # 
    # it "should mark all new users as not active" do
    #   @user.active?.should == false
    # end

  end
end