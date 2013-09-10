window.app.factory 'Event', ->

  class Event

    constructor: (event) ->
      @description = event.description
      @area = event.area

      @startsAt = new Date Date.parse(event.starts_at)
      @endsAt = new Date Date.parse(event.ends_at)

    isOngoing: ->
      today = new Date()
      @startsAt <= today <= @endsAt

    isUpcoming: ->
      today = new Date()
      today < @startsAt

    multipleDays: ->
      @startsAt < @endsAt

    isWithinRange: (rangeStartMonth, rangeEndMonth) ->
      @endsAt.getMonth() >= rangeStartMonth and rangeEndMonth >= @startsAt.getMonth()
