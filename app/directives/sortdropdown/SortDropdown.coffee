template = require './SortDropdown.html'
require './SortDropdown.less'

module.exports = ->
  #TODO: build dropdown from data
  types = ["name", "price", "promotion"]
  orders = ["low", "high"]
  return {
    replace: true
    restrict: 'AE'
    scope:
      type: '=?'
      order: '=?'
    template: template
    link: (scope, element) ->

      # default settings if not set
      if scope.type not in types
        scope.type = types[0]
      if scope.order not in orders
        scope.order = orders[0]

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
