source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :test, :development do
  gem 'sqlite3' # test
  gem 'rspec-rails'
  gem 'debugger'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'teaspoon'
  gem 'selenium-webdriver'
end

gem 'mysql2', :group => :production

# For caching
gem 'redis' 

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'haml_coffee_assets'

  gem 'requirejs-rails'
  gem 'backbone-rails', :git => 'https://github.com/popox/backbone-rails.git',:branch => 'v1.1'
  gem 'backbone-relational-rails'
  gem 'marionette-rails'
  gem 'jquery-rails'
  gem 'jquery-tokeninput-rails'
  gem 'leaflet-rails'
  gem 'leaflet-markercluster-rails'

  # Bootstrap
  gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails', :git => 'https://github.com/anjlab/bootstrap-rails.git',:branch => 'v2.3.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

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
