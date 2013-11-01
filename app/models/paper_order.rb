class PaperOrder < ActiveRecord::Base
  has_many :order_items ,:dependent=>:destroy
  belongs_to :exam

  ORDER_TYPES=[
    ["非毕业班",1],
    ["毕业班",2]
  ]



  ORDER_STATES=[
    ["可提交",true],
    ["关闭",false]
  ]

  def self.types_hash
    ORDER_TYPES.inject({}) do |hash,value|
      hash[value.last]=value.first
      hash
    end
  end

  def gather
    gather={:qxes=>[],s=>{}}
    
    Qx.all.each do |qx|
      qx.schools.each do |school|
        schoolarr=[]
        order=self.order_items.find_by_school_id(school)
        if order
          
        else

        end
        
      end
    end
  end
end
