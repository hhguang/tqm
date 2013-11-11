module ApplicationHelper
	def encodingChange(attr)
     if !attr.nil?  
       return attr.force_encoding(Encoding.default_internal)
     end
	end

	def bigbag(n)
    n = n || 0
    return n>0 ? (n/30.0).round : 0
  end

  def smallbag(n)
    n = n || 0
    return (n>0 && (n % 30)!=0 && (n % 30)<15) ? 1 : 0
  end

  def current_user_tag
    if current_user
      return School.find(current_user.school_id).name if current_user.is_school?
      return "系统管理员" if current_user.is_s_admin?
      return "#{Qx.find(current_user.qx_id).name}管理员" if current_user.is_qx_admin?
    end
  end
end
