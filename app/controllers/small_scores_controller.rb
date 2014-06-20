class SmallScoresController < ApplicationController
  before_action :login_required
  before_action :set_exam

  def index
    @schools = @current_user.own_shools
    @small_scores = @exam.small_scores.where(school_id: @schools).
      group_by{|report|report.school_id}
  end

  def show
    @school = School.find(params[:id])
    @grade_name = params[:grade_name] || Exam::SUBJECTS[@exam.exam_type-1][0][:grade]
    @subject_name = params[:subject_name] || Exam::SUBJECTS[@exam.exam_type-1][0][:name][0]
    @small_scores = []
    (1..75).each { |i| @small_scores[i] = SmallScore.find_or_initialize_by(grade_name: @grade_name,
       subject_name: @subject_name, school_id: @school.id, exam_id: @exam.id, bh: i) }

  end

  def create
    @school = School.find(params[:school_id])
    @grade_name = params[:grade_name]
    @subject_name = params[:subject_name]
    @small_scores = []
    params[:small_scores].each do |key, item|
      @small_scores[key.to_i] = SmallScore.find_or_initialize_by(grade_name: @grade_name,
       subject_name: @subject_name, school_id: @school.id, exam_id: @exam.id, bh: item[:bh])
      @small_scores[key.to_i].average = item[:average]
      @small_scores[key.to_i].scoring_average = item[:scoring_average]
      @small_scores[key.to_i].save
    end
    @errors = @small_scores.sum { |item| (item && item.errors.any?) ? item.errors.count : 0 }
    if @errors==0
      flash[:notice] = "已成功保存"
      redirect_to action: "show", id: @school
    else
      render action: "show", id: @school
    end

  end

  def export
    @school = School.find(params[:school_id])
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam=Exam.find(params[:exam_id])
      redirect_to root_url, :alert => '项目已关闭' if @exam.closed? && !current_user.is_s_admin?
    rescue
      redirect_to root_url, :alert => '项目不存在'
    end
end
