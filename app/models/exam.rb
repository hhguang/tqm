class Exam < ActiveRecord::Base
	validates :name ,:presence => true
end
