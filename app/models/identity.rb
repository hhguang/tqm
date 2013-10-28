class Identity < OmniAuth::Identity::Models::ActiveRecord
	validates_presence_of :name
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i

  def self.create_from_user(user,password)
  	identity=create!(:name=>user.login,
  			:email=>user.email,
  			:password=>password,
  			:password_confirmation=>password)
  	Authentication.create!(:provider=>'identity',
  						:uid=>identity.id,
  						:user_id=>user.id)
  end
end
