class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  private

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  
  	def current_user=(new_user)
      session[:user_id] = new_user ? new_user.id : nil
      @current_user = new_user || false
    end

    def logout_keeping_session!
      # Kill server-side auth cookie
      # @current_user.forget_me if @current_user.is_a? User
      @current_user = false     # not logged in, and don't do it for me
      # kill_remember_cookie!     # Kill client-side auth cookie
      session[:user_id] = nil   # keeps the session but kill our variable
      # explicitly kill any other session variables you set
    end
end
