class Report < ActiveRecord::Base
	belongs_to :exam
	belongs_to :school
	
	validates :file,presence: true
	mount_uploader :file, ReportFileUploader
end
