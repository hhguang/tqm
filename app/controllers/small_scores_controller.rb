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
