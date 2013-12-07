class ScoreFilesController < ApplicationController
	before_action :set_exam, only: [:index,:new,:create,:show,:update,:edit,:by_school]

  def index
  end

  def show

  end

  def by_school
  	@school=School.find(params[:school_id])
  	@score_file=ScoreFile.new
  end

  def new
  end

  def edit
  end

  def update
  end

  def create
  	params.permit!
  	@school=School.find(params[:score_file][:school_id])
  	@score_file=ScoreFile.new(params[:score_file])
  	if @score_file.save
  	 redirect_to :action=>'by_school',:exam_id=>@exam.id,:school_id=>@school.id
    else
      render :by_school
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:exam_id])
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_file_params
      params.require(:exam).permit(:filename, :exam_id,:school_id)
    end
end
