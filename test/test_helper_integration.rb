require File.expand_path('../test_helper', __FILE__)

require 'capybara/rails'
require 'database_cleaner'

Capybara.default_driver = :selenium
DatabaseCleaner.strategy = :truncation

class IntegrationTestCase < ActionDispatch::IntegrationTest

  include Rails.application.routes.url_helpers
  include Capybara::DSL

  self.use_transactional_fixtures = false

  setup do
    Capybara.reset_sessions!
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end

end
