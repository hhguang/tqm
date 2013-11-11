module OrderItemsHelper
  def bigbag(n)
    n = n || 0
    return n>0 ? (n/30.0).round : 0
  end

  def smallbag(n)
    n = n || 0
    return (n>0 && (n % 30)!=0 && (n % 30)<15) ? 1 : 0
  end

#  def quantity(arr,item)
#
#  end
end
