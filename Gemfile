source 'https://rubygems.org'

gem 'rails'

gem 'pg', :group => :production

group :test, :development do
  gem 'sqlite3' # test
  gem 'rspec-rails'
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'factory_girl_rails'
  gem 'teaspoon'
  gem 'selenium-webdriver'
end

# Gems used only for assets (needed to precompile assets in production while the precompilation is not handled by anyone else for now..)
# (group :assets in Rails 3.2)
group :test, :development, :production do
  gem 'sprockets-rails', :require => 'sprockets/railtie'
  gem 'bootstrap-sass'
  gem 'sass-rails'
  gem 'font-awesome-sass'
  gem 'coffee-rails'
  gem 'haml_coffee_assets', :git => 'https://github.com/popox/haml_coffee_assets'

  gem 'backbone-rails'
  gem 'backbone-relational-rails'
  gem 'marionette-rails'
  gem 'jquery-rails'
  gem 'jquery-tokeninput-rails', :git => 'https://github.com/popox/jquery-tokeninput-rails'
  gem 'leaflet-rails'
  gem 'leaflet-markercluster-rails'

  # Purecss
  gem 'purecss-rails'

 gem 'uglifier', '>= 1.0.3'
end

#gem 'requirejs-rails', :git => 'https://github.com/jwhitley/requirejs-rails.git',:branch => 'master'
gem 'requirejs-rails'

# Move to Haml templating framework instead of erb
gem 'haml-rails'

gem 'meta-tags', :require => 'meta_tags'

# Devise - Authentication gem
gem 'devise'
gem 'devise-encryptable'

gem 'omniauth'
# Google OAuth 2.0
gem 'omniauth-google-oauth2'
# Twitter OAuth 1.1
gem 'omniauth-twitter'
# GitHub OAuth 2.0
gem 'omniauth-github'

# Ruby Geocoder
gem 'geocoder'

# Imdb Data directly from www.imdb.com
gem 'imdb', :git => 'https://github.com/popox/imdb'

gem 'will_paginate'

gem 'pry'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'
