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
    self.auth_token_digest = Shaf::CurrentUser.digest(name)
    super
  end
end

