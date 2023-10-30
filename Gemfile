# frozen_string_literal: true
source "https://rubygems.org"
ruby '3.1.0'

gem 'shaf'
gem 'sinatra', require: 'sinatra/base'
gem 'rake'
gem 'puma'
gem 'sequel'
gem 'sinatra-sequel'
gem 'bcrypt'
gem 'hal_presenter'
gem 'redcarpet'
gem 'faker'
gem 'sqlite3'

group :production, :development do
  gem 'pg'
end

group :development, :test do
  gem 'yard'
  gem 'byebug'
  gem 'irb'
end

group :test do
  gem 'minitest'
  gem 'minitest-hooks'
  gem 'rack-test'
end

