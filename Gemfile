source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

gem 'rails', '~> 5.2.0.rc1'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'active_model_serializers'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'responders'
gem 'uglifier'

group :development do
  gem 'pry'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq',  require: false
  gem 'capistrano3-puma',   require: false
end

group :test do
  gem 'capybara', '~> 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
