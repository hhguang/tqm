class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :set_exam
  before_action :login_required
  # authorize_resource
  # GET /reports
  # GET /reports.json
  def index
    
    if @current_user.is_school? 
      redirect_to :action=>'show_by_school',:school_id=>@current_user.school_id
    else
      @qx=params[:qx_id]
      @qx=Qx.find(@current_user.qx_id) if @current_user.is_qx_admin?
      if @qx
        @schools=@qx.schools
      else
        @schools=School.all
      end
    end

  end

  # GET /reports/1
  # GET /reports/1.json
  def show    
    authorize! :read, @report
    send_file @report.file.current_path,:filename=>@report.file_name
    
  end

  def show_by_school
    @school=School.find(params[:school_id])
    @reports=@school.exam_reports(@exam)
    # authorize! :show_by_school, @school
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @school=  @report.school
    @reports=@school.exam_reports(@exam)
    authorize! :create, @report
    respond_to do |format|
      if @report.save
        format.html { redirect_to show_by_school_exam_reports_path(@exam,school_id: @report.school_id), notice: '文件已成功上传.' }
        format.json { render action: 'show', status: :created, location: @report }
      else
        format.html { render action: 'show_by_school'}
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    authorize! :destroy, @report
    @school=@report.school
    @report.destroy

    respond_to do |format|
      format.html { redirect_to show_by_school_exam_reports_path(@exam,school_id: @school.id),notice: '文件已删除' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam=Exam.find(params[:exam_id])
    end
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:title, :exam_id, :school_id, :user_id, :file, :file_name, :subject_name, :group_name)
    end
end
