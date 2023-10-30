require 'securerandom'

class User < Sequel::Model
  one_to_many :posts
  one_to_many :bookmarks

  def validate
    super
    validates_presence [:name]
    validates_min_length 3, :name
  end

  def before_create
    # This is currenly not used.
    self.auth_token_digest = SecureRandom.hex
    super
  end
end

