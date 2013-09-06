window.app = angular.module('Festive', [])

window.eventsController = ($scope, $http) ->

  $scope.events = []

  $scope.ongoingClass = (endsAt) ->
    endsAt = new Date(Date.parse(endsAt))
    today = new Date()

    if today <= endsAt then 'ongoing' else 'outdated'

  $scope.sameDay = (date, otherDate) ->
    date == otherDate

  sliderData = [
    { text: 'Jan', date: new Date('2013-01-01') }
    { text: 'Feb', date: new Date('2013-02-01') }
    { text: 'Mär', date: new Date('2013-03-01') }
    { text: 'Apr', date: new Date('2013-04-01') }
    { text: 'Mai', date: new Date('2013-05-01') }
    { text: 'Jun', date: new Date('2013-06-01') }
    { text: 'Jul', date: new Date('2013-07-01') }
    { text: 'Aug', date: new Date('2013-08-01') }
    { text: 'Sep', date: new Date('2013-09-01') }
    { text: 'Okt', date: new Date('2013-10-01') }
    { text: 'Nov', date: new Date('2013-11-01') }
    { text: 'Dez', date: new Date('2013-12-01') }
  ]

  slider = new Razorfish.Slider
    width: 890
    handleWidth: 12
    useRange: true
    tabs: sliderData

  startMonth = (new Date()).getMonth()
  endMonth = startMonth + 1
  endMonth = 11 if endMonth > 11

  $scope.safeApply = (fn) ->
    phase = @$root.$$phase
    if phase is "$apply" or phase is "$digest"
      fn()  if fn and (typeof (fn) is "function")
    else
      @$apply fn

  $scope.rangeChanged = (e, rangeStartMonth, rangeEndMonth) ->
    events = _.select $scope.allEvents, (event) ->
      startMonth = new Date(Date.parse(event.starts_at)).getMonth()
      endMonth = new Date(Date.parse(event.ends_at)).getMonth()

      (startMonth >= rangeStartMonth && startMonth <= rangeEndMonth) ||
      (endMonth >= rangeStartMonth && endMonth <= rangeEndMonth)

    $scope.$apply ->
      $scope.events = events

  $http.get('/events.json').success (data) ->
    $scope.allEvents = data;

    slider
      .appendTo('#range-slider')
      .setRange(startMonth, endMonth)
      .bind('change', $scope.rangeChanged)
      .triggerChange()
