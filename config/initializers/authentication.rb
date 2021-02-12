Shaf::Authenticator::BasicAuth.restricted realm: 'demo' do |user:, **|
  # This is only for demo purposes!!
  User.where(name: user).first if user
end
