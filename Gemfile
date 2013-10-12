source 'https://rubygems.org'

gem 'rails', '3.2.14'

gem 'mysql2', :group => :production

group :test, :development do
  gem 'sqlite3' # test
  gem 'rspec-rails'
  gem 'debugger'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'teaspoon'
  gem 'selenium-webdriver'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'haml_coffee_assets'

  gem 'backbone-rails', :git => 'https://github.com/popox/backbone-rails.git',:branch => 'v1.1'
  gem 'backbone-relational-rails'
  gem 'marionette-rails'
  gem 'jquery-rails'
  gem 'jquery-tokeninput-rails', :git => 'https://github.com/popox/jquery-tokeninput-rails'
  gem 'leaflet-rails'
  gem 'leaflet-markercluster-rails'

  # Purecss
  gem 'purecss-rails', :git => 'https://github.com/popox/purecss-rails.git',:tag => 'global'

  # Bootstrap
  gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails', :git => 'https://github.com/anjlab/bootstrap-rails.git',:branch => 'v2.3.0.0'

  gem 'uglifier', '>= 1.0.3'
end

gem 'requirejs-rails', :git => 'https://github.com/popox/requirejs-rails.git',:branch => 'expe'

# Move to Haml templating framework instead of erb
gem 'haml-rails'

gem 'meta-tags', :require => 'meta_tags'

# Devise - Authentication gem
gem 'devise', '~> 2.2.3'
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

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
