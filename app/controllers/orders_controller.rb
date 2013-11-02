class OrdersController < ApplicationController
  def new
  	@exam=Exam.find(params[:id])
  	@paper_order=@exam.paper_order
  	@order_item=@paper_order.order_items.new
  end

  def show
  end

  def edit
  end

  def create
  end
end
