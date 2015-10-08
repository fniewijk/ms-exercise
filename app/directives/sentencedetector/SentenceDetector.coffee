template = require './SentenceDetector.html'
require './SentenceDetector.less'

module.exports = (sentenceSplitter) ->

  return {
    replace: true
    restrict: 'AE'
    template: template
    link: (scope, element) ->
      if not scope.inputString
        scope.inputString = ""
      scope.sentences = []

      scope.sentences = sentenceSplitter.analyze(scope.inputString)
      scope.$watch('inputString', (inputString) ->
        scope.sentences = sentenceSplitter.analyze(inputString)
      , this)
  }

module.exports.$inject = ['sentenceSplitter']
