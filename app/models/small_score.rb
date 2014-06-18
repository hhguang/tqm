class SmallScore < ActiveRecord::Base
  belongs_to :exam
  validates :average, :numericality=>{:greater_than_or_equal_to=>0}, allow_nil: true
  validates :scoring_average,:numericality=>{:greater_than_or_equal_to=>0}, allow_nil: true
end
