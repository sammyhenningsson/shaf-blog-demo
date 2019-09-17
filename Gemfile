# frozen_string_literal: true
source "https://rubygems.org"
ruby '2.6.1'

gem 'shaf'
gem 'sinatra', require: 'sinatra/base'
gem 'rake'
gem 'thin'
gem 'sequel'
gem 'sinatra-sequel'
gem 'bcrypt'
gem 'hal_presenter'
gem 'redcarpet'

group :production, :development do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem 'faker'
  gem 'byebug'
end

group :test do
  gem 'minitest'
  gem 'minitest-hooks'
  gem 'rack-test'
end
