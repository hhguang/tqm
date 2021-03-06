class SessionsController < ApplicationController
	skip_before_filter :verify_authenticity_token  

	def new
	end
	def create
		user = User.from_auth(env["omniauth.auth"])
	    session[:user_id] = user.id
	    redirect_to root_url, notice: "Signed in!"
	end

	def failure
	    redirect_to root_url, notice: "Authentication failed, please try again."
	end
end
