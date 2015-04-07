class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :comments

  before_save {self.email = email.downcase}
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

end
