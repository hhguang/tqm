class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html {redirect_to root_url, :alert => exception.message}
      format.js { render :template =>'/share/msg',:locals=>{:alert_msg=> exception.message} }

    end
    
  end

  def login_required
      !!current_user || access_denied
  end

  def access_denied
      respond_to do |format|
        format.html do
          # store_location
          redirect_to welcome_new_path
        end
        # format.any doesn't work in rails version < http://dev.rubyonrails.org/changeset/8987
        # Add any other API formats here.  (Some browsers, notably IE6, send Accept: */* and trigger
        # the 'format.any' block incorrectly. See http://bit.ly/ie6_borken or http://bit.ly/ie6_borken2
        # for a workaround.)
        format.any(:json, :xml) do
          request_http_basic_authentication 'Web Password'
        end
      end
    end
  
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
