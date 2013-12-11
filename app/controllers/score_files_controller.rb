class ScoreFilesController < ApplicationController
	before_action :set_exam, only: [:index,:new,:create,:show,:update,:edit,:by_school]

  def index
    @score_files=@exam.score_files
    @schools=School.all
  end

  def show

  end

  def by_school
  	
  	
    @f_type=params[:f_type] || '0'
    if current_user.is_school?
      @school=current_user.school
      @score_file = ScoreFile.find(:first,
      :conditions=>{:exam_id=>@exam,:school_id=>current_user.school,:f_type=>@f_type}
      )
    #@score_file =current_user.school.score_file_for(@exam) || ScoreFile.new
      if @score_file        

         @csv_data=@score_file.csv_data
         @error=@csv_data[:error]
         @data=@csv_data[:rows]
      else
        
        @score_file= ScoreFile.new
      end
    else
      @school=School.find(params[:school_id])
      @score_file= ScoreFile.new
    end
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
    @score_file.user_id=current_user.id
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
