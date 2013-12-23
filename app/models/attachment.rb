class Attachment < ActiveRecord::Base
	# belongs_to :article
	belongs_to :attachable,  polymorphic: true

	mount_uploader :file,AttachmentUploader

	before_create :set_file_size
	def set_file_size
	    if file.present? && file_changed?
	      self.file_size = file.file.size
	    end
	end
end
