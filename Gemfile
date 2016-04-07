source 'https://rubygems.org'


gem 'rails', '4.2.5'
gem 'rails-api'
gem 'figaro'
gem 'faraday'



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
