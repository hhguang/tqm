require 'digest/sha1'
class User < ActiveRecord::Base
	validates :login, :presence => true
	validates :name, :presence => true
  	validates :email, :presence => true, :uniqueness => true
	has_many :authentications
	has_many :role,:through=>:users_roles_relations

	serialize :subjects


	REST_AUTH_SITE_KEY         = 'dffec9f93a1e566d545fc11590b50bd408e40624'
	REST_AUTH_DIGEST_STRETCHES = 10

	attr_accessor :password,:password_confirmation

	accepts_nested_attributes_for :authentications

	before_save :clean_subjects
	before_save :encrypt_password

	def encrypt_password
        return if password.blank?
        self.salt = self.make_token if new_record?
        self.crypted_password = encrypt(password)
    end

    def clean_subjects
    	subjects.delete('')
    end

    def make_token
      secure_digest(Time.now, (1..10).map{ rand.to_s })
    end

	def school
		School.find(self.school_id) if self.is_school?
	end

	def is_jyy?
		subjects && subjects.any?
	end

	def manage_subject?(subject)

		if is_admin?
			return true
		elsif is_jyy?
			subjects.include?(subject)
		else
			false
		end
	end

	def is_school?
		! school_id.nil?
	end

	def is_s_admin?
		is_admin? && qx_id.nil?
	end

	def is_qx_admin?
		is_admin? && (! qx_id.nil?)
	end

  def own_shools
    if self.is_school?
      return School.where(id: self.school_id)
    elsif self.is_qx_admin?
      return School.where(qx_id: self.qx_id)
    elsif self.is_admin? || self.is_jyy?
      return School.all
    end
  end

	def self.from_auth(auth)
	    locate_auth(auth)
	end

	def self.locate_auth(auth)
	    Authentication.find_by_provider_and_uid(auth[:provider],
	                                              auth[:uid]).try(:user)
	end



	  def self.create_with_omniauth(auth)
	    create!(
          :name => auth[:info][:name],
          :email => auth[:info][:email],
          :authentications_attributes => [
            Authentication.new(:provider => auth[:provider],
                               :uid => auth[:uid]
                              ).attributes
      ])
	  end


	  def self.authenticate(login, password)
	    return nil if login.blank? || password.blank?
	    u = find_by_login(login.downcase) # need to get the salt
	    u && u.authenticated?(password) ? u : nil
	  end

	  def authenticated?(password)
        crypted_password == encrypt(password)
      end

      def encrypt(password)

        digest = REST_AUTH_SITE_KEY
        REST_AUTH_DIGEST_STRETCHES.times do
          digest = secure_digest(digest, salt, password, REST_AUTH_SITE_KEY)
        end
        digest
      end

    def secure_digest(*args)
      Digest::SHA1.hexdigest(args.flatten.join('--'))
    end

end
