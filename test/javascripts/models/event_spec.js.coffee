describe 'Event', ->

  beforeEach module('Festive')

  beforeEach inject ($injector) ->
    @Event = $injector.get 'Event'


  describe '#description', ->
    it 'returns the event description', ->
      event = new @Event(description: 'Hellersdorfer Erntefest mit Kirmes')
      assert event.description == 'Hellersdorfer Erntefest mit Kirmes'


  describe '#area', ->
    it 'returns the area of the event', ->
      event = new @Event(area: 'Marzahn-Hellersdorf')
      assert event.area == 'Marzahn-Hellersdorf'


  describe '#isOngoing', ->
    it 'returns true if the event is ongoing', ->
      event = new @Event(starts_at: '2013-10-15', ends_at: '2013-10-18')
      mockToday(event, '2013-10-17')

      assert event.isOngoing()

    it 'returns false if the event is upcoming', ->
      event = new @Event(starts_at: '2013-10-18', ends_at: '2013-10-24')
      mockToday(event, '2013-10-17')

      assert !event.isOngoing()

    it 'returns false if the event is passed', ->
      event = new @Event(starts_at: '2013-10-10', ends_at: '2013-10-16')
      mockToday(event, '2013-10-17')

      assert !event.isOngoing()


  describe '#isUpcoming', ->
    it 'returns true if the event is upcoming', ->
      event = new @Event(starts_at: '2013-10-18', ends_at: '2013-10-24')
      mockToday(event, '2013-10-17')

      assert event.isUpcoming()

    it 'returns false if the event is passed', ->
      event = new @Event(starts_at: '2013-10-10', ends_at: '2013-10-16')
      mockToday(event, '2013-10-17')

      assert !event.isUpcoming()


  describe '#isWithinRange', ->
    it 'returns true if the event is within the given month-range', ->
      event = new @Event(starts_at: '2013-10-18', ends_at: '2013-10-24')
      assert event.isWithinRange(9, 11)

    it 'returns false if the event is not within range ', ->
      event = new @Event(starts_at: '2013-10-18', ends_at: '2013-10-24')
      assert !event.isWithinRange(3, 6)


  mockToday = (event, date) ->
    event._today = new Date Date.parse(date)

