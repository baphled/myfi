source 'https://rubygems.org'

gem 'rails',     :git => 'git://github.com/rails/rails.git', :branch => '3-2-stable'
gem 'journey',   :git => 'git://github.com/rails/journey.git'
gem 'arel',      :git => 'git://github.com/rails/arel.git', :branch => '3-0-stable'

gem 'bcrypt-ruby'

gem 'mongoid', "~> 3.0.0.rc"
gem 'bson_ext'

gem "active_attr"
gem 'simple_form'
gem 'validates_timeliness'

gem "recurrence", :require => "recurrence/namespace"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   :git => 'git://github.com/rails/sass-rails.git', :branch => '3-2-stable'
  gem 'coffee-rails', :git => 'git://github.com/rails/coffee-rails.git', :branch => '3-2-stable'

  gem 'bootstrap-sass'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

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
#
group :test do
  gem 'cucumber-rails'
  gem 'timecop'
  gem 'launchy'
end

group :test, :development do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'cucumber'
  gem 'capybara'
  gem 'database_cleaner'
end
