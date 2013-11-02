class Exam < ActiveRecord::Base
	has_one :paper_order
	validates :name ,:presence => true
	EXAM_TYPES=[
	    ["非毕业班",1],
	    ["毕业班",2]
	  ]

  	# accepts_nested_attributes_for :paper_order

  	
end
