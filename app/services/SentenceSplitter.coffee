module.exports = ->

  analyze: (sentenceString) ->
    regex = /[A-Z]{1}(.|\n)+?(\.|(\!\?)|(\?\!)|\?|\!)(\s|\n|$){1}/gm
    sentenceString.match(regex)

module.exports.$inject = []
