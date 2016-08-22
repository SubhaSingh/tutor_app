class User < ActiveRecord::Base
	attr_accessor 	:remember_token, :activation_token, :reset_token #To set a instance variable
	before_save 	:downcase_email  #To avoid the same user being saved to database multiple times 
	before_create 	:create_activation_digest
	validates :name,  presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255},
						format: {with: VALID_EMAIL_REGEX} , uniqueness: { case_sensitive: false }
	has_secure_password #Has separate validation upon object creation
	validates :password, presence: true, length: { minimum: 6}, allow_nil: true #allow nil for updating user profiles without changing their original passwords

	#Paperclip user avatar

	has_attached_file :avatar, :styles => {
		:tiny => '50x50>',
		:thumb => '100x100>',
		:square => '200x200#',
		:medium => '300x300>'
	},
	 default_url: 'missing.jpg',
	 :storage => :s3,
	 :bucket => 'tutorapp'
    # :s3_credentials => "#{Rails.root}/config/aws.yml"


	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	validates_attachment_size :avatar, less_than: 3.megabytes, message: 'Image must be smaller than 3mb' 



	has_many :lecturers
	has_many :tutors
	has_many :convenors

	has_many :courses_convening, through: :convenors, source: :course
	has_many :courses_lecturing, through: :lecturers, source: :course
	has_many :courses_tutoring, through: :tutors, source: :course
	#member posts model has not been used - status feed for all course posts not necessary in this application
	has_many :meeting_members
	has_many :assessment_tutors
	has_many :posts

	has_many :course_meetings, through: :meeting_members, source: :meeting
	has_many :course_assessments, through: :assessment_tutors, source: :assessment
	
	
	# Returns the hash digest of the given string
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  	  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
	end

	#Returns a random token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	#Remembers a user inthe database for persistent sessions
	def remember
		self.remember_token =  User.new_token  #set users remember_token attribute
		update_attribute(:remember_digest, User.digest(remember_token))
	end
	#Returns true if the given token matches the digest.
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	#forgets a user when they log out
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Activates an account.
  	def activate
    	update_columns(activated: true, activated_at: Time.zone.now)
  	end

  	# Sends activation email.
  	def send_activation_email
    	UserMailer.account_activation(self).deliver_now
  	end

  	#Sets the password reset attributes
  	def create_reset_digest
  		self.reset_token = User.new_token
  		update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  	end

  	#Sends the password reset attributes
  	def send_password_reset_email
  		UserMailer.password_reset(self).deliver_now
  	end

  	#Returns true if a password reset has expired
  	def password_reset_expired?
  		reset_sent_at < 3.hours.ago
  	end

	private
		#Converts email address to lower case before saving to the database
		def downcase_email
			self.email = email.downcase
		end

		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(activation_token)
		end


end
