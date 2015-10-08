module.exports = ->

  analyze: (sentenceString) ->
    if sentenceString
      regex = /[A-Z]{1}(.|\n)+?(\.|(\!\?)|(\?\!)|\?|\!)(\s|\n|$){1}/gm
      result = String(sentenceString).match(regex)
      return result if result and result.length > 0
    return []

module.exports.$inject = []
