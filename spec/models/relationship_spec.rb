require 'spec_helper'

describe Relationship do
  
  before(:each) do
    @follower = Factory(:user)
    @followed = Factory(:user, :email => Factory.next(:email))
    
    @attr = { :followed_id => @followed.id }
  end

  it "should create a new instance given valid attributes" do
    @follower.relationships.create!(@attr)
  end
  
  describe "follow methods" do
    
    before(:each) do
      @relationship = @follower.relationships.create!(@attr)
    end
    
    it "should have a follower attribute" do
      @relationship.should respond_to(:follower)
    end
    
    it "should have the right follower" do
      @relationship.follower.should == @follower
    end
    
    it "should have a followed attribute" do
      @relationship.should respond_to(:followed)
    end
    
    it "should have the right follower" do
      @relationship.followed.should == @followed
    end
  end
  
  describe "validations" do
    
    before(:each) do
      @relationship = @follower.relationships.create!(@attr)
    end
    
    it "should require a follower_id" do
      @relationship.follower_id = nil
      @relationship.should_not be_valid
    end

    it "should require a followed_id" do
      @relationship.followed_id = nil
      @relationship.should_not be_valid
    end
  end
end
