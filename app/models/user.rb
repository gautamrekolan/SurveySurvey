class User < ActiveRecord::Base
  
  has_many :surveys, :dependent => :destroy
  has_many :responses
  
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :unique_id
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # Validation for name and email
  validates :name, :presence => true,
                   :length => { :maximum => 50 } 
  validates :email, :presence => true, 
                    :uniqueness => { :case_sensitive => false }, 
                    :format => { :with => email_regex }
  
  # Automatically create the virtual attribute 'password_confirmation'
  validates :password, :on => :create,
                       :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..40 }
  
  # Validation for user.unique_id
  # validates :unique_id, :length => { :is => 4 }
  
  before_save :encrypt_password
  before_create { generate_token(:auth_token) }
  
  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    return nil if user.nil?
    return user if user.salt == cookie_salt
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.hex
    end while User.exists?(column => self[column])
  end
  
  private
    
    #before_save :encrypt_password
    
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
