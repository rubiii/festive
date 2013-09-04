require 'test_helper'

class ImportWorkerTest < ActiveSupport::TestCase

  setup do
    @event_data = fixture('event_data.json')
    response = HTTP::Message.new_response(@event_data)

    HTTPClient.any_instance.expects(:get).with(ImportWorker::ENDPOINT).returns(response)
  end

  test 'imports all events from the default source' do
    ImportWorker.new.run
    assert_equal 20, Event.count
  end

  test 'imports all data for every event' do
    ImportWorker.new.run

    event = Event.first
    event_data = JSON.parse(@event_data)['index'].first

    assert_equal event_data['id'],              event.source_id
    assert_equal event_data['bezirk'],          event.area
    assert_equal event_data['bezeichnung'],     event.description
    assert_equal event_data['strasse'],         event.street
    assert_equal event_data['plz'],             event.zip_code
    assert_equal Date.parse(event_data['von']), event.starts_at
    assert_equal Date.parse(event_data['bis']), event.ends_at
    assert_equal event_data['zeit'],            event.period
    assert_equal event_data['veranstalter'],    event.host
    assert_equal event_data['mail'],            event.email
    assert_equal event_data['www'],             event.website
    assert_equal event_data['bemerkung'],       event.note
  end

  def fixture(filename)
    File.read Rails.root.join('test', 'fixtures', filename)
  end

end
