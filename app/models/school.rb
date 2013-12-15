class School < ActiveRecord::Base
	belongs_to :qx
	has_many :score_files
	has_many :users
	has_many :order_items
	has_many :reports

	def score_files_for(exam)
	    self.score_files.where(:exam_id=>exam.id)
	end
end
