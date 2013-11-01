class OrderItem < ActiveRecord::Base
  belongs_to :paper_order
  belongs_to :school

  validates_presence_of :paper_order_id,:school_id,:handler,:telephone
  validates_numericality_of :g1yw,:g1sx,:g1yy,:g1wl,:g1hx,:g1sw,:g1zz,:g1ls,:g1dl,:g2w,:g2l,:g2yw,:g2sxw,:g2sxl,:g2yy,:g2wl,:g2hx,:g2sw,:g2zz,:g2ls,:g2dl,:g3w,:g3l,:g3yw,:g3sxw,:g3sxl,:g3yy,:g3wz,:g3lz,
    :allow_nil=>true,
    :only_integer=>true,
    :greater_than_or_equal_to=>0

  before_save :set_g2_and_g3
  def set_g2_and_g3
    self.school_name=School.find(self.school_id).name
    if self.g2w
      self.g2sxw=self.g2w
      self.g2zz=self.g2w
      self.g2ls=self.g2w
      self.g2dl=self.g2w
      self.g2yw=self.g2w
      self.g2yy=self.g2w
    end
    if self.g2l
      self.g2sxl=g2l
      self.g2wl=g2l
      self.g2hx=g2l
      self.g2sw=g2l
      self.g2yw=self.g2l
      self.g2yy=self.g2l
      self
    end
    if self.g2w && self.g2l
      self.g2yw=self.g2w+self.g2l
      self.g2yy=self.g2w+self.g2l
    end
  end

end
