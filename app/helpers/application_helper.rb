module ApplicationHelper
	def encodingChange(attr)
     if !attr.nil?  
       return attr.force_encoding(Encoding.default_internal)
     end
	end
end
