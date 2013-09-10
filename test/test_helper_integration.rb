require File.expand_path('../test_helper', __FILE__)

require 'capybara/rails'

Capybara.default_driver = :selenium
DatabaseCleaner.strategy = :truncation

class IntegrationTestCase < ActiveSupport::TestCase

  include Rails.application.routes.url_helpers
  include Capybara::DSL
  #include FactoryGirl::Syntax::Methods

  use_transactional_fixtures = false

  setup do
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end

end
