template = require './ProductList.html'
require './ProductList.less'

module.exports = ->
  return {
    replace: true
    restrict: 'AE'
    template: template
    scope:
      data: '=?'
    link: (scope, element) ->

  }

module.exports.$inject = []
