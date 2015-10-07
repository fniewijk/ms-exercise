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

      # a bit messy. I guess I would make it configurable or use the data attribute fields to
      if not scope.type
        scope.type = "name"
      if not scope.order
        scope.order = "low"

      scope.$watch('selected', (inputString) ->
        if inputString
          split = inputString.split('-')
          scope.type = split[0]
          scope.order = split[1]
      , this)

      scope.selected = scope.type + '-' + scope.order
  }

module.exports.$inject = []
