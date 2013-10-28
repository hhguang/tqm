class Role < ActiveRecord::Base
	has_many :user,:through=>:users_roles_relations
	has_many :permissions
end
