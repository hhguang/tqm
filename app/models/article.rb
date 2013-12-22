class Article < ActiveRecord::Base
	belongs_to :exam
	has_many	:attachments, :dependent => :destroy
	
	validates :title ,:presence => true

	accepts_nested_attributes_for :attachments, :reject_if => lambda { |a| a[:file].blank? }, :allow_destroy => true

end
