require 'openssl'

class User < ActiveRecord::Base

  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new


  has_many :questions
  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'has invalid format' }
  validates :username, format: { with: /\A[a-zA-Z0-9_]+\z/, message: 'may only contain latin letters, numbers and \'_\' sign'}
  validates :username, length: { maximum: 40 }

  attr_accessor :password

  validates :password, presence: true, on: :create
  validates :password, confirmation: true

  before_validation :downcase_username
  before_save :encrypt_password

  def downcase_username
    self.username = username.downcase
  end

  def encrypt_password
    if self.password.present?
      # Creating salt
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      # Creating password hash
      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  # converting a binary string into HEX
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

end
