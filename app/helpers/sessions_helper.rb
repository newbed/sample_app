module SessionsHelper
  
  def sign_in(user)
    #lesson 9... puts remember_token on user's browser that is secure
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user #TODO: why did I have to put self. in front?
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    #either pulls @current_user or (if nil) pulls user from remember token
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def deny_access
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  private
  
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
  
end
