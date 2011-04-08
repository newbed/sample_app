class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    # just to raise an exception to see what's in params[:user]
    # raise params[:user].inspect
    @user = User.new(params[:user])
    if @user.save
             # or user_path(@user)
      redirect_to @user, :flash => { :success => "Welcome to the Sample App!"}
    else
      @title = "Sign up"
      render 'new'
    end
  end

end
