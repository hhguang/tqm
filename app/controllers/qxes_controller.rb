class QxesController < ApplicationController
  before_action :set_qx, only: [:show, :edit, :update, :destroy]
  authorize_resource
  # before_filter :login_required
  # GET /qxes
  # GET /qxes.xml
  def index
    @qxes = Qx.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @qxes }
    end
  end

  # GET /qxes/1
  # GET /qxes/1.xml
  def show    

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @qx }
    end
  end

  # GET /qxes/new
  # GET /qxes/new.xml
  def new
    @qx = Qx.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @qx }
    end
  end

  # GET /qxes/1/edit
  def edit
    
  end

  # POST /qxes
  # POST /qxes.xml
  def create
    @qx = Qx.new(qx_params)

    respond_to do |format|
      if @qx.save
        format.html { redirect_to(@qx, :notice => 'Qx was successfully created.') }
        format.xml  { render :xml => @qx, :status => :created, :location => @qx }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @qx.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /qxes/1
  # PUT /qxes/1.xml
  def update    

    respond_to do |format|
      if @qx.update_attributes(qx_params)
        format.html { redirect_to(@qx, :notice => 'Qx was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @qx.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /qxes/1
  # DELETE /qxes/1.xml
  def destroy    
    @qx.destroy
    respond_to do |format|
      format.html { redirect_to(qxes_url) }
      format.xml  { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qx
      @qx = Qx.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qx_params
      params.require(:qx).permit(:code, :name)
    end
end
