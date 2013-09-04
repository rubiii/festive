class ImportWorker

  ENDPOINT = 'http://www.berlin.de/sen/wirtschaft/service/maerkte/strassenfeste/index.php/index/all.json?q='

  def initialize
    @client = HTTPClient.new
  end

  def run(endpoint = ENDPOINT)
    data = get_data_from_source(endpoint)

    event_count = data['results']['count']
    event_data  = data['index']

    puts "Importing #{event_count} events"

    event_data.each do |data|
      data = sanitize_data(data)
      source_id = data['id']

      event = map_to_event_hash(data)
      upsert_event(source_id, event)
    end
  end

  private

  def get_data_from_source(endpoint)
    response = @client.get(endpoint)
    JSON.parse(response.body)
  end

  def sanitize_data(data)
    data.each_with_object({}) { |(key, value), memo|
      memo[key] = value.strip
    }
  end

  def map_to_event_hash(data)
    {
      source_id:   data['id'],
      area:        data['bezirk'],
      description: data['bezeichnung'],
      street:      data['strasse'],
      zip_code:    data['plz'],
      starts_at:   Date.parse(data['von']),
      ends_at:     Date.parse(data['bis']),
      period:      data['zeit'],
      host:        data['veranstalter'],
      email:       data['mail'],
      website:     data['www'],
      note:        data['bemerkung']
    }
  end

  def upsert_event(source_id, attributes)
    Event.where(source_id: source_id)
      .first_or_initialize
      .update_attributes(attributes)
  end

end
