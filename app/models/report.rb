class Report < ActiveRecord::Base
	belongs_to :exam
	belongs_to :school
	
	mount_uploader :file, ReportFileUploader
end
