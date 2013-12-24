class Exam < ActiveRecord::Base
	has_many :score_files
	has_one :paper_order
	has_many :reports
	has_many	:topics
	validates :name ,:presence => true
	EXAM_TYPES=[
	    ["非毕业班",1],
	    ["毕业班",2]
	  ]

	GROUPS=[		
		[{
			:f_type=>0,
			:name=>'高一'
			},
		{
			:f_type=>1,
			:name=>'高二理科'
			},
		{
			:f_type=>2,
			:name=>'高二文科'
			}],			
		[{
			:f_type=>3,
			:name=>'高三理科'
			},
		{
			:f_type=>4,
			:name=>'高三文科'
			}]
			
	]
  	# accepts_nested_attributes_for :paper_order

  	
end
