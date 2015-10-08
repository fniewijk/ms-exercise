SentenceSplitter = require './SentenceSplitter.coffee'

describe 'SentenceSplitter', ->

  sentenceSplitter = null
  defaultData = "I am not surprised. I am very surprised! Am I surprised? I am surprised, are you? I’m not surprised; that’s pretty cool though. On a scale of 1 – 10, how surprised are you? You don’t look surprised. Are you kidding me?! Of course I’m surprised, who wouldn’t be!? It’s amazing!"

  beforeEach ->
    angular.mock.module('app')

    inject (_sentenceSplitter_) ->
      sentenceSplitter = _sentenceSplitter_

  it 'no value gives an array back with no elements', ->

      returnObject = sentenceSplitter.analyze()

      expect(returnObject.length).to.equal 0

  it 'empty string gives an array back with no elements', ->

    returnObject = sentenceSplitter.analyze("")

    expect(returnObject.length).to.equal 0

  it 'integer gives an array back with no elements', ->

    returnObject = sentenceSplitter.analyze(1)

    expect(returnObject.length).to.equal 0

  it 'undefined gives an array back with no elements', ->

    returnObject = sentenceSplitter.analyze(undefined)

    expect(returnObject.length).to.equal 0

  it 'mock data gives back 10 results', ->

    returnObject = sentenceSplitter.analyze(defaultData)

    expect(returnObject.length).to.equal 10

  it 'it doesnt get confused by urls', ->

    returnObject = sentenceSplitter.analyze("Hello this is a sentence with a www.ms.co.uk url.")

    expect(returnObject.length).to.equal 1
