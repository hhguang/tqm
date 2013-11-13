class ExamsController < ApplicationController
	before_action :set_exam, only: [:start,:order_on_off,:show, :edit, :update, :destroy]
	def index
		@exams=Exam.all.order 'created_at desc'
	end

	def new
		@exam=Exam.new
		
		respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @goods_stock }
	      format.js
	    end
	end

	def create
		# params.permit!
		@exam=Exam.new(exam_params)

		respond_to do |format|
			if @exam.save
				@exam.create_paper_order(
					:name=>@exam.name,
					:item_type=>@exam.exam_type,
					:state=>false
					)
		        format.html { redirect_to(exams_url, :notice => '考试已成功创建') }
		        format.xml  { render :xml => @exam, :status => :created, :location => @exam }
		        format.js
		    else
		        format.html { render :action => "new" }
		        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
		        format.js
		    end
		end
	end

	def show
		@exam=Exam.find(params[:id])
		@paper_order=@exam.paper_order
	end

	def start
		@exam.update(:closed=>!@exam.closed?)
		redirect_to(exam_url(@exam), :notice => "监测项目已#{@exam.closed? ? '关闭' : '启动'}")	

	end

	def order_on_off
		@paper_order=@exam.paper_order
		@paper_order.update :state=>!@paper_order.state?
		redirect_to(exam_url(@exam), :notice => "试卷订单已#{@paper_order.state? ? '关闭' : '启动'}")	
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_params
      params.require(:exam).permit(:exam_type, :name,:brief)
    end

end
