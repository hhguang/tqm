class OrdersController < ApplicationController
  before_action :set_exam, only: [:index,:new,:create,:show,:update,:edit]

  def index
    if current_user.is_school? && @order_item = OrderItem.find_by(paper_order_id: @paper_order.id,school_id: current_user.school_id) 
      redirect_to exam_order_path(@exam,@order_item)
    else
      redirect_to new_exam_order_path(@exam)
    end
  end
  
  def new
  	# @exam=Exam.find(params[:id])
  	# @paper_order=@exam.paper_order
  	@order_item=@paper_order.order_items.new
  end

  def show
    @order_item = OrderItem.find(params[:id]) 

  end

  def edit
    # @order_item = OrderItem.find(params[:order_item_id]) if params[:order_item_id]    
     @order_item = OrderItem.find(params[:id]) 
  end

  def create
    params.permit!
    @order_item = OrderItem.new(params[:order_item])
    # @school=current_user.school
    # @paper_order=PaperOrder.find(params[:order_item][:paper_order_id])
    respond_to do |format|
      if @order_item.save
        flash[:notice]= '订单已成功提交.'
        format.html { redirect_to(:action=>'show',:order_item_id=>@order_item,:id=>@exam.id) }
        
      else
        format.html { render :action => "new" }
        
      end
    end
  end

  def update
    params.permit!
    @order_item = OrderItem.find(params[:id])
    # @school=current_user.school
    respond_to do |format|
      if @order_item.update_attributes(params[:order_item])
        
        format.html { redirect_to(:action=>'show',:id=>@order_item,:exam_id=>@exam) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:exam_id])
      @paper_order=@exam.paper_order
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_params
      params.require(:exam).permit(:exam_type, :name,:brief)
    end




end
