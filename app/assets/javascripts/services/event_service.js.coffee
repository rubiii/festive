window.app.factory 'eventService', ['Event', (Event) ->

  # Selects events in a given month-range and groups them by their status
  # (ongoing, upcoming or passed).
  group: (allEvents, rangeStartMonth, rangeEndMonth) ->
    events = { ongoing: [], upcoming: [], passed: [] }
    rangeEndMonth -= 1  # rangeEnd is exclusive

    allEvents.forEach (e) ->
      event = new Event(e)

      if event.isWithinRange(rangeStartMonth, rangeEndMonth)
        group = switch
          when event.isOngoing()  then 'ongoing'
          when event.isUpcoming() then 'upcoming'
          else                         'passed'

        events[group].push event

    events

  # Expects a grouped list of events and returns the sum of all events
  # from all groups.
  countGrouped: (groupedEvents) ->
    lengths = _.map groupedEvents, (value) -> value.length
    _.reduce lengths, ((memo, i) -> memo + i), 0

  ]
