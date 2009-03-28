require File.dirname(__FILE__) + '/../spec_helper'

describe "User Belongs To Site" do
  before(:all) do
    Merb::Router.prepare { add_slice(:merb_auth_slice_multisite)}
  end

  after(:all) do
    Merb::Router.reset!
  end

  describe "UserBelongsToSite Mixin" do

    before(:each) do
      User.all.destroy!
      @user = User.new(valid_user_attributes)
    end

    it "should add the 'site_id' property to the user model" do
      @user.should respond_to(:site_id)
      @user.should respond_to(:site_id=)
    end
    
    it "should be invalid when site_id is nil" do
      @user.site_id = nil
      @user.save
      @user.should_not be_valid
    end
    
    it "should have a unique login and email" do
      @user.save
      @user.should be_valid

      # not unique
      @user2 = User.new(valid_user_attributes)
      @user2.should_not be_valid
      
      # unique email but duplicate login should fail
      @user2 = User.new(valid_user_attributes)
      @user2.email = "different@example.org"
      @user2.should_not be_valid
      
      # unique login but duplicate email should fail
      @user2 = User.new(valid_user_attributes)
      @user2.login = "different"
      @user2.should_not be_valid
      
      # unique login & unique email should be valid
      @user2 = User.new(valid_user_attributes)
      @user2.login = "unique"
      @user2.email = "unique@example.org"
      @user2.should be_valid
    end

  end
end