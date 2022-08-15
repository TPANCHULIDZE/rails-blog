source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "rails", "~> 7.0.3"

gem 'redis', '~> 4.7', '>= 4.7.1'

gem 'omniauth-google-oauth2'

gem 'google-apis-drive_v3', '~> 0.26.0'

gem "omniauth-rails_csrf_protection"

gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'

gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'

gem 'sidekiq'

gem "sprockets-rails"

gem 'i18n'

gem 'stripe'

gem "geocoder"

gem 'whenever', require: false

gem 'ransack', :github => 'activerecord-hackery/ransack', :branch => 'main'

gem 'telephone_number'

gem "pg", "~> 1.1"

gem "puma", "~> 5.0"

gem "importmap-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem 'draper'

gem "jbuilder"

gem 'file_validators'

gem 'will_paginate', '~> 3.3'

gem 'will_paginate-bootstrap-style'

gem "slim-rails"

gem 'carrierwave', '~> 2.0'

gem "kredis"

# gem "bcrypt", "~> 3.1.7"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

gem 'rspec-rails'

gem 'devise'

gem 'shoulda-matchers', '~> 5.0'

gem "pundit", "~> 2.2"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails'  
end

group :development do
  gem "web-console"
end

group :test do
  gem "rails-controller-testing"
  gem 'capybara' 
end

