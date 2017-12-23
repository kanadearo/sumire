class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  private
  
  include SessionsHelper
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user) 
    @count_posts = user.posts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_favoritings = user.favoritings.count
  end  

end