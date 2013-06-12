source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.13'
gem 'rack', '~> 1.4.5'
gem 'json', '>= 1.7.7'


gem 'strong_parameters'

gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem 'bootstrap-sass', '~> 2.3.1.0'

  # Synchronizes assets to S3
  gem 'asset_sync'
end

gem 'jquery-rails'


# Running development
gem 'foreman', :group => :development

# In memory caching system, used by geocoder (and probably other things)
gem 'redis'

# For caching and sessions
gem 'redis-rails'

# Better webserver
gem 'unicorn'


# Better error display in development
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

# For loading environment vars
gem 'dotenv-rails', :groups => [:development, :test]

# Required for some reason
gem 'psych'


# Nice forms and stuff
gem 'simple_form'

gem 'nokogiri'