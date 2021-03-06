source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.6'
gem 'mysql2'
gem 'jquery-rails'
gem 'html5-rails'
gem 'copycopter_client', '2.0.0'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
  gem 'twitter-bootstrap-rails'
  gem 'compass-rails'
  gem 'compass-h5bp'
  gem 'therubyracer'
end

group :utils do
  gem 'log4r'               # Logging utility
  gem 'rconfig'             # Configuration utility
  gem 'simple_form'         # Form generation helper
  gem 'chronic'             # Natural language Date
  gem 'inherited_resources' # Rest action utility
  gem 'activeadmin'         # Admin Rails Engine
  gem 'meta_search'         # OO Searching/Search Forms
  gem 'tld'                 # Top Level Domains
  gem 'kaminari'            # Pagination utility
  gem 'iso_country_codes'   # Country Code lookup
  gem 'addressable'         # Ruby URI update
  gem 'delayed_job_active_record' # Background Jobs
end

group :security do
  gem 'oauth'        # Oauth utility
  gem 'devise'       # Authentication
  gem 'cancan'       # Authorization
  gem 'friendly_id'  # permalink user routing
end

group :omniauth do
  gem 'omniauth'          # Multi-provider Authentication Services
  gem 'omniauth-facebook' # Facebook authentication
  gem 'omniauth-twitter'  # Twitter authentication
  gem 'omniauth-tumblr'   # Tumblr authentication
end

group :apis do
  gem 'fb_graph', require: 'fb_graph' # Facebook Graph API
  gem 'linkedin', require: 'linkedin' # LinkedIn API
  gem 'twitter',  require: 'twitter'  # Twitter API
  #gem 'tumblr',   require: 'tumblr'   # Tumblr API
end

group :images do
  gem 'mini_magick' # Image processor
  gem 'carrierwave' # Image upload
  gem 'fog'         # AWS API
end

gem 'awesome_print', group: 'development'

group :development, :test do
  gem 'simplecov'
  gem 'ruby-prof'
end

group :test do
  gem 'rspec-rails'
  gem 'redgreen'
  gem 'shoulda'
  gem 'nokogiri'
  gem 'factory_girl_rails'
  gem 'timecop'
  gem 'fabrication'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'spork'
  gem 'fakeweb'
  gem 'ZenTest'
  gem 'autotest'
  gem 'autotest-rails'
  gem 'autotest-growl'
end
