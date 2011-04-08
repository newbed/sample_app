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
    
    it "should have the right URL" do
      get :show, :id  => @user.id
      response.should have_selector('td>a', :content => user_path(@user),
                                            :href    => user_path(@user))
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
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = {:name  => "", :email => "", :password => "",
                 :password_confirmation => ""}
      end
      
      it "should have the right title" do
        post :create, :user => @attr 
        response.should have_selector('title', :content => "Sign up")
      end
      
      it "should render the 'new' page" do
        post :create, :user => @attr 
        response.should render_template('new')
      end
      
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count) #change is method in rspec
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = {:name  => "New User", :email => "user@example.com", 
                 :password => "foobar",
                 :password_confirmation => "foobar"}
      end
      
      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it "should redirect to the user show page" do
        post :create, user: @attr #as a test used fat colon syntax vs hashrocket
        response.should redirect_to(user_path(assigns(:user))) #assigns pulls user?
      end
      
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample app/i
      end
      
      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end

  end

end
    
