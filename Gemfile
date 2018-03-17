# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.3.3'

##### -- Generated gems -----------------------------
gem 'rails', '5.0.0.1'
gem 'pg', '~> 0.18'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'
# Server
gem 'puma'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

### --- My Gems --------------------------------------------------
gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem "font-awesome-rails"
gem 'webpacker', '~> 3.3', '>= 3.3.1'
gem 'react-rails', '~> 2.4', '>= 2.4.4'

source 'https://rails-assets.org' do
  gem 'rails-assets-pathfinding'
  gem 'rails-assets-jquery-touch-events'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-teaspoon'

  # --- Testing Frameworks -------------------------------------
  gem 'rspec-rails', '~> 3.5'
  gem 'rails-controller-testing'
  # Teaspoon can use phantomjs for headless testing
  # https://github.com/jejacks0n/teaspoon
  gem "teaspoon-jasmine"

  # --- Testing Tools -------------------------------------
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'awesome_print', '~> 1.8'
end

group :test do
  gem 'capybara'
  # Poltergeist requires phantomjs to be installed on the machine.
  # http://phantomjs.org/download.html
  gem 'poltergeist'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  # https://github.com/thoughtbot/shoulda-matchers
  gem 'shoulda-matchers', '~> 3.1'
  # https://github.com/jdliss/shoulda-callback-matchers
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'database_cleaner'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :production do
  gem 'rails_12factor'
end

# From another project
# gem 'figaro'
# gem 'devise'
# gem 'redis'

# gem 'font-awesome-sass'
# gem 'simple_form'


# group :development, :test do
#   gem 'binding_of_caller'
#   gem 'better_errors'
##   gem 'quiet_assets'#deprecated
#   gem 'pry-byebug'
#   gem 'pry-rails'

#   gem 'spring-commands-rspec'

# end

# group :test do
#   gem 'guard-rspec', require: false
#   gem 'launchy'
# end
