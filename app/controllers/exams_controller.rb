class ExamsController < ApplicationController
	before_action :set_exam, only: [:show, :edit, :update, :destroy]
	def index
		@exams=Exam.all
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
		params.permit!
		@exam=Exam.new(params[:exam])

		respond_to do |format|
			if @exam.save
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
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_params
      params.require(:exam).permit(:code, :name,:qx_id)
    end

end
