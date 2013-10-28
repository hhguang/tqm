class WelcomeController < ApplicationController
  def index
  	@exams=Exam.where(:closed=>false)
  end

  def new

  end

  def create
  	user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user     
      Identity.create_from_user(user,params[:password])
      redirect_to :action=>'index'
      flash[:notice] = "您已经成功登录"
    else
      logout_keeping_session!
      flash[:error] = "用户名或密码错误"
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_keeping_session!
    reset_session
    flash[:notice] = "您已经退出系统."
    redirect_to :action=>'new'
  end


end
