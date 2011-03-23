require 'spec_helper'

describe UsersController do
  render_views #because we deleted the default views spec... so doing it here

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector('title', :content => 'Sign up')
    end
    
  end

end
