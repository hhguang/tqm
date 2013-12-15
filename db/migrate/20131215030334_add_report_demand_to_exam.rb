class AddReportDemandToExam < ActiveRecord::Migration
  def change
    add_column :exams, :report_demand, :text
    add_column	:exams,:report_started,:boolean,:default=>false
  end
end
