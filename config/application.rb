require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module BlockchainStart
  class Application < Rails::Application
  end
end
