class Qx < ActiveRecord::Base
  has_many :schools

  def score_files_for(exam)
    ScoreFile.find_all_by_exam_id_and_school_id(exam.id,self.schools)
  end
end
