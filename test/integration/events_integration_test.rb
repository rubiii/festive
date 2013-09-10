require 'test_helper_integration'

class EventsIntegrationTest < IntegrationTestCase

  test 'that it works' do
    visit '/'
    assert page.has_content?('Berlin')
  end

end
