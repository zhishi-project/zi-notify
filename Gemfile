source 'https://rubygems.org'


gem 'rails', '4.2.5'
gem 'rails-api'
gem 'figaro'
gem 'faraday'
gem 'slack-ruby-client'
gem 'hashie'
gem "puma"
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sidekiq-status'
gem 'redis-namespace'
gem 'sidekiq-scheduler'
gem 'sinatra', '>= 1.3.0', require: false
gem 'paper_trail'
gem 'jwt'
gem 'newrelic_rpm'

group :development, :test do
  gem 'spring'
  gem "sqlite3"
  gem "pry-rails"
  gem "pry-nav"
  gem "faker"
end

group :test do
  gem "rspec-rails"
  gem "shoulda-matchers", require: false
  gem "codeclimate-test-reporter"
  gem 'simplecov', :require => false, :group => :test
  gem 'coveralls', require: false
  gem "factory_girl_rails"
  gem "database_cleaner"
end

group :production, :staging do
  gem "pg"
  gem "rails_12factor"
end
