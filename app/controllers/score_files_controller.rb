class ScoreFilesController < ApplicationController
	before_action :set_exam, only: [:index,:new,:create,:show,:update,:edit,:by_school,:export]
  before_action :login_required
  authorize_resource 

  def index 
    
    @qx=params[:qx_id]
    @qx=Qx.find(@current_user.qx_id) if @current_user.is_qx_admin?
    if @qx
      @schools=@qx.schools
    else
      @schools=School.all
    end
  end

  def show
    @score_file=ScoreFile.find(params[:id])   
    authorize! :read, @score_file
    send_file @score_file.file.current_path,:filename=>@score_file.filename
    # respond_to do |format|
    #   format.html      
    #   format.csv {send_file @score_file.filename,:filename=>@score_file.file.current_path}
    # end
  end

  def by_school  	
  	@school=School.find(params[:school_id])

    @f_type=params[:f_type] || '0'          
    # @score_file = ScoreFile.find(:first,
    #   :conditions=>{:exam_id=>@exam,:school_id=>@school,:f_type=>@f_type}
    #   )
     @score_file=ScoreFile.where(exam_id: @exam,school_id: @school,f_type: @f_type).first
    
      if @score_file        
         @csv_data=@score_file.csv_data
         @error=@csv_data[:error]
         @data=@csv_data[:rows]
      else        
        @score_file= ScoreFile.new
      end

    # authorize! :manger, @score_file
    
  rescue
    @file_error="无法读取上传的文件"   
  # authorize! :by_school, @school
  end

  def new
  end

  def edit
  end

  def update
    params.permit!
    @school=School.find(params[:score_file][:school_id])    
    @f_type=params[:score_file][:f_type]
    @score_file=ScoreFile.find(params[:id])    
    authorize! :update, @score_file

    if @score_file.update_attributes(params[:score_file])
      redirect_to :action=>'by_school',:exam_id=>@exam.id,:school_id=>@school.id,:f_type=>@f_type
    else
      render :by_school
    end
  end

  def confirm
    
    @score_file=ScoreFile.find(params[:id])  
    authorize! :confirm, @score_file
    if @score_file.update(:confirmed=>true)
      flash[:notice]="成绩文件已确认"
    end
    redirect_to :action=>'by_school',:exam_id=>@score_file.exam_id,:school_id=>@score_file.school_id,:f_type=>@score_file.f_type
        
  end

  def cancel
    @score_file=ScoreFile.find(params[:id])  
    authorize! :cancel, @score_file

    if @score_file.update(:confirmed=>false)
      flash[:notice]="成绩文件已取消确认"
    end
    redirect_to :action=>'index',:exam_id=>@score_file.exam_id
  end

  def create
  	params.permit!
  	@school=School.find(params[:score_file][:school_id])
    @f_type=params[:score_file][:f_type]
  	@score_file=ScoreFile.new(params[:score_file])
    @score_file.user_id=current_user.id
    authorize! :create, @score_file
  	if @score_file.save
  	 redirect_to :action=>'by_school',:exam_id=>@exam.id,:school_id=>@school.id,:f_type=>@f_type
    else
      render :by_school
    end
  end

  def export
    @qx=params[:qx_id]
    @qx=Qx.find(@current_user.qx_id) if @current_user.is_qx_admin?
    if @qx
      @score_files=@exam.score_files.where(confirmed: true,:school_id=>@qx.schools.map { |s|s.id  }).group_by{|f|f.f_type}
    else
      @score_files=@exam.score_files.where(confirmed: true).group_by{|f|f.f_type}
    end
    respond_to do |format|
      format.html
      format.csv { send_data @products.to_csv }
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
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
