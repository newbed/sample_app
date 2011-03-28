require 'spec_helper'

describe UsersController do
  render_views #because we deleted the default views spec... so doing it here

  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user.id  # don't need the .id (rails is permissive)
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user.id
      assigns(:user).should == @user #NB... 1:13 lesson 7 video
    end
    
    it "should have the right title" do
      get :show, :id => @user.id
      response.should have_selector('title', :content => @user.name)
    end
    
    it "should have the user's name" do
      get :show, :id  => @user.id
      response.should have_selector('h1', :content => @user.name)
    end
    
    it "should have profile image (globally recognized...) image" do
      get :show, :id  => @user.id
      response.should have_selector('h1>img', :class => 'gravatar')
    end
    
  end


  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector('title', :content => 'Sign up')
    end
    
  end

end
