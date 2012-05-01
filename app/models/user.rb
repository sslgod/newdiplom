class User < ActiveRecord::Base

has_many :kplans
has_many :ktitls

 attr_accessible(:nik, :pas, :pas_confirmation, :salt, :name, :predmet_comissia)

  validates :nik,  :presence => true,
	           :uniqueness => true	    
	    
	    
  validates :pas,      :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
                       
	      
  before_save :encrypt_password

def self.authenticate(nik, submitted_password)
    user = User.find_by_nik(nik)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
end

def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
end

    def encrypt_password
      self.salt = make_salt if new_record?
      self.pas = encrypt(pas)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{pas}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
   def has_password?(submitted_password)
	       pas == encrypt(submitted_password)
			    
	      
    end
end
  
   


# == Schema Information
#
# Table name: users
#
#  id               :integer         not null, primary key
#  nik              :string(255)	login
#  name             :string(255)	FIO
#  pas              :string(255)	password (encrypted)
#  salt             :string(255)	for encryption 
#  tip              :integer		type of user (rools)
#  predmet_comissia :integer		number of subject's сommission 
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

