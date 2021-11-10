# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "bootsnap", ">= 1.4.4", require: false
gem "devise", "~> 4.8"
gem "dotenv-rails"
gem "faker", "~> 2.19"
gem "jbuilder", "~> 2.7"
gem "mysql2", "~> 0.5.3"
gem "omniauth", "~> 2.0", ">= 2.0.4"
gem "omniauth-facebook", "~> 9.0"
gem "omniauth-google-oauth2", "~> 1.0"
gem "omniauth-rails_csrf_protection"
gem "pry", "~> 0.14.1"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.4", ">= 6.1.4.1"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "rails-controller-testing", "~> 1.0", ">= 1.0.5"
  gem "rspec-rails", "~> 5.0", ">= 5.0.2"
  gem "rubocop", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-thread_safety", require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 4.1.0"
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "database_cleaner"
  gem "factory_bot_rails", "~> 6.2"
  gem "selenium-webdriver"
  gem "simplecov", require: false
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
