source "https://rubygems.org"

ruby "3.4.2"

# Core Rails and Database
gem "rails", "~> 8.0.2"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bcrypt", "~> 3.1"

# Performance Optimization
gem "oj"
gem "bullet"
gem "rack-mini-profiler"
gem "fast_jsonapi"

# Environment Configuration
gem "dotenv-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Linting and Code Quality
gem "rubocop", require: false
gem "rubocop-rails", require: false
gem "rubocop-performance", require: false

group :development, :test do
  # Testing Framework
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "shoulda-matchers"

  # Debugging and Development Tools
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Security
  gem "brakeman", require: false
end

# Development Tools
group :development do
  # Live Reload and Performance
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"

  gem "annotate" # Annotates models with schema info
  gem "letter_opener" # Preview emails in browser

  # debugging tools
  gem "better_errors"
  gem "binding_of_caller"
  gem "pry-rails"
  gem "pry-byebug"
end

group :test do
  gem "database_cleaner-active_record"

  # Browser Testing
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "simplecov", require: false
  gem "vcr"
  gem "webmock"
end

group :production do
  gem "rails_stdout_logging"
end
