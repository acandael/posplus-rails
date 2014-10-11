class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :password, :full_name
  validates :password, length: { :minimum => 8 }
  validates :email, presence: true,
                    format: /\A\S+@\S+\z/,
                    uniqueness: { case_sensitive: false }

end
