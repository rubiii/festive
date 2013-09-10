require 'test_helper_integration'

class EventsIntegrationTest < IntegrationTestCase

  setup do
    @ongoing = Event.create(
      description: 'Ongoing Event',
      area: 'Marzahn-Hellersdorf',
      starts_at: 3.days.ago,
      ends_at: 2.days.from_now
    )

    @upcoming = Event.create(
      description: 'Upcoming Event',
      area: 'Marzahn-Hellersdorf',
      starts_at: 1.day.from_now,
      ends_at: 5.days.from_now
    )

    @passed = Event.create(
      description: 'Upcoming Event',
      area: 'Marzahn-Hellersdorf',
      starts_at: 5.days.ago,
      ends_at: 1.day.ago
    )
  end

  test 'it displays ongoing, upcoming and passed events' do
    visit '/'

    assert page.has_content?('1 laufende Veranstaltung(en)')
    assert page.has_content?('1 anstehende Veranstaltung(en)')
    assert page.has_content?('1 vergangene Veranstaltung(en)')
  end

end
