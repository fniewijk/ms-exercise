template = require './SortDropdown.html'
require './SortDropdown.less'
$ = require 'jquery'

module.exports = ->

  return {
    replace: true
    restrict: 'AE'
    scope:
      type: '=?'
      order: '=?'
    template: template
    link: (scope, element) ->

      # default settings if not set
      if not scope.type
        scope.type = "name"
      if not scope.order
        scope.order = "low"

      scope.$watch('selected', (inputString) ->
        if inputString
          # Alternatively I could've used data properties.
          split = inputString.split('-')
          scope.type = split[0]
          scope.order = split[1]
      , this)

      scope.selected = scope.type + '-' + scope.order
  }

module.exports.$inject = []
