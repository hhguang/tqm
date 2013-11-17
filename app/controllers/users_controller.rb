
class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
  	@users=User.all
  end

  def new
  	@user=User.new
  end

  def create
  	@user =User.new(user_params)
    respond_to do |format|
      if @user.save
        flash[:notice]='用户已经成功创建'
        format.html { redirect_to :action=>'index' }
        format.xml  { head :ok }
      else
        flash[:error]='用户创建出错'
        format.html { render :action => "new" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        flash[:notice]='用户已经成功更新'
        format.html { redirect_to :action=>'index' }
        format.xml  { head :ok }
      else
        flash[:error]='用户更新出错'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:login, :name,:password,:password_confirmation,:email,:school_id,:qx_id,:is_admin)
    end
end
