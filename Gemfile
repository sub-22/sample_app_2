source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.1"

gem "rails", "~> 6.1.2", ">= 6.1.2.1"
gem "mysql2", "~> 0.5.3"
gem "puma", "~> 5.0"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 5.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "rails-i18n"
gem "config"
gem "bootsnap", ">= 1.4.4", require: false

group :development, :test do
  gem "pry", "~> 0.14.0"
end

group :development do
  gem "web-console", ">= 4.1.0"
  gem "rack-mini-profiler", "~> 2.0"
  gem "listen", "~> 3.3"
  gem "spring"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :development, :test do
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
