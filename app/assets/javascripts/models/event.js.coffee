window.app.factory 'Event', ->

  class Event

    constructor: (event) ->
      @description = event.description
      @area = event.area

      @startsAt = new Date Date.parse(event.starts_at)
      @endsAt = new Date Date.parse(event.ends_at)

    isOngoing: ->
      @startsAt <= @_today <= @endsAt

    isUpcoming: ->
      @_today < @startsAt

    isWithinRange: (rangeStartMonth, rangeEndMonth) ->
      @endsAt.getMonth() >= rangeStartMonth and rangeEndMonth >= @startsAt.getMonth()

    _today: ->
      new Date()
