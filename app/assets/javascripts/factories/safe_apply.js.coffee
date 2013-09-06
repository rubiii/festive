window.app.factory 'safeApply', [
  ($rootScope) ->
    ($scope, fn) ->
        phase = $scope.$root.$$phase

        if phase == '$apply' || phase == '$digest'
          $scope.$eval(fn) if fn
        else
          if fn
            $scope.$apply(fn)
          else
            $scope.$apply()
  ]
