class SmallScoresController < ApplicationController
  before_action :set_exam

  def index
    @schools = School.all
    @small_scores = @exam.small_scores.group_by{|report|report.school_id}
  end

  def show
    @school = School.find(params[:id])
    @grade_name = '高一'
    @subject_name = '语文'
    @small_scores = []
    (1..75).each { |i| @small_scores[i] = SmallScore.new(bh: i) }
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

    render action: "show"
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
