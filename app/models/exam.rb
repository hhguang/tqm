class Exam < ActiveRecord::Base
	has_many :score_files
	has_one :paper_order
	has_many :reports
	has_many	:topics
	has_many :small_scores
	validates :name ,:presence => true
	EXAM_TYPES=[
	    ["非毕业班",1],
	    ["毕业班",2]
	  ]

	SUBJECTS=[
		[{
			:id=>1,
			:grade=>'高一',
			:name=>['语文','数学','英语','政治','历史','地理','物理','化学','生物']
		},{
			:id=>2,
			:grade=>'高二',
			:name=>['语文','文科数学','理科数学','英语','政治','历史','地理','物理','化学','生物']
		}
		],[{
			:id=>3,
			:grade=>'高三',
			:name=>['语文','文科数学','理科数学','英语','政治','历史','地理','物理','化学','生物']
		}
		]
	]

	GROUPS=[
		[{
			:f_type=>0,
			:name=>'高一',
			:subjects=>['语文','数学','英语','政治','历史','地理','物理','化学','生物']
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
