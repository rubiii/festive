window.app = angular.module('Festive', [])

window.eventsController = ($scope, $http, safeApply, eventService) ->

  $scope.groupedEvents = {}
  $scope.groupedEventsCount = 0

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
    { text: 'Jan', date: new Date('2014-01-01') }
  ]

  slider = new Razorfish.Slider
    width: 890
    handleWidth: 13
    useRange: true
    tabs: sliderData

  startMonth = (new Date()).getMonth()
  endMonth = startMonth + 1
  endMonth = 11 if endMonth > 11

  rangeChanged = (e, rangeStartMonth, rangeEndMonth) ->
    groupedEvents = eventService.group($scope.allEvents, rangeStartMonth, rangeEndMonth)

    safeApply $scope, ->
      $scope.groupedEvents = groupedEvents
      $scope.groupedEventsCount = eventService.countGrouped(groupedEvents)

  $http.get('/events.json').success (data) ->
    $scope.allEvents = data;

    slider
      .appendTo('#range-slider')
      .setRange(startMonth, endMonth)
      .bind('change', rangeChanged)
      .triggerChange()
