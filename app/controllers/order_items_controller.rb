class OrderItemsController < ApplicationController
  
  before_filter :find_paper_order
  authorize_resource
  # GET /order_items
  # GET /order_items.xml
  def index
    
    if current_user.is_qx_admin?
      
      @qx=Qx.find(current_user.qx_id)
      @schools=@qx.schools
      @order_items=@paper_order.order_items.find_all_by_school_id(@schools.map{|s|s.id}).to_a
      @unorders=@schools-@order_items.collect{|i| i.school }
    elsif current_user.is_s_admin?
      @order_items = @paper_order.order_items
      @unorders=School.all-@order_items.collect{|i| i.school }
    end
     
  end

  # GET /order_items/1
  # GET /order_items/1.xml
  def show
    @order_item = OrderItem.find(params[:id])
    authorize! :read, @order_item
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order_item }
    end
  end

  # GET /order_items/new
  # GET /order_items/new.xml
  def new
    if current_user.is_school? && @order_item = OrderItem.find_by(paper_order_id: @paper_order.id,school_id: current_user.school_id) 
      
        redirect_to exam_order_path(@exam,@order_item)
    else
    
    @order_item = OrderItem.new
    @order_item.school_id=current_user.school_id if current_user.is_school?
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order_item }
    end
    end
  end

  # GET /order_items/1/edit
  def edit
    @order_item = OrderItem.find(params[:id])
  end

  # POST /order_items
  # POST /order_items.xml
  def create
    params.permit!
    @order_item = OrderItem.new(params[:order_item])

    respond_to do |format|
      if @order_item.save
        format.html { redirect_to( edit_exam_order_item_url(@exam,@order_item), :notice => '订单已成功创建.') }
        format.xml  { render :xml => @order_item, :status => :created, :location => @order_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /order_items/1
  # PUT /order_items/1.xml
  def update
    params.permit!
    @order_item = OrderItem.find(params[:id])

    respond_to do |format|
      if @order_item.update_attributes(params[:order_item])
        format.html { redirect_to( edit_exam_order_item_url(@exam,@order_item), :notice => '订单已成功修改.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.xml
  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy

    respond_to do |format|
      format.html { redirect_to(exam_order_items_url(@exam)) }
      format.xml  { head :ok }
    end
  end

  def confirm
    @order_item = OrderItem.find(params[:id])
    @order_item.update(:confirmed=>true)
    flash[:notice]="订单已确认"
    redirect_to exam_order_item_path(@exam,@order_item)
  end

  def cancel
    params.permit!
    @order_item = OrderItem.find(params[:id])

    respond_to do |format|
      if @order_item.update_attributes(params[:order_item])
        format.html { redirect_to( exam_order_items_url, :notice => 'OrderItem was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @order_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def gather    
    
    if current_user.qx_id
    @qx=Qx.find(current_user.qx_id)
    @schools=@qx.schools
    @order_items=@paper_order.order_items.find_all_by_school_id(@schools.map{|s|s.id}).to_a
    @school_orders=@order_items.index_by{|item| item.school_id }
    else
      @schools=School.all
      @order_items = @paper_order.order_items
      @school_orders=@order_items.index_by{|item| item.school_id }
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @paper_orders }
    end
  end

  protected

  def find_paper_order
    
    @exam=Exam.find(params[:exam_id])
    @paper_order=@exam.paper_order || @exam.create_paper_order(
          :name=>@exam.name,
          :item_type=>@exam.exam_type,
          :state=>false
          )
  end
end
