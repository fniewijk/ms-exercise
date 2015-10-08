_ = require 'lodash'

require './SentenceDetector.coffee'

describe 'SentenceDetector', ->
  $rootScope = $compile = $sentenceSplitter = null
  defaultTemplate = '<sentence-detector></sentence-detector>'
  defaultData = "I am not surprised. I am very surprised! Am I surprised? I am surprised, are you? I’m not surprised; that’s pretty cool though. On a scale of 1 – 10, how surprised are you? You don’t look surprised. Are you kidding me?! Of course I’m surprised, who wouldn’t be!? It’s amazing!"
  mockService = {
    analyze : (inputString) ->
      return ["I am not surprised.", "I am very surprised!", "Am I surprised?", "I am surprised, are you?", "I’m not surprised; that’s pretty cool though.", "On a scale of 1 – 10, how surprised are you?", "You don’t look surprised.", "Are you kidding me?!", "Of course I’m surprised, who wouldn’t be!?", "It’s amazing!"]
  }

  createDirective = (data, template) ->
    $rootScope.inputString = data
    elem = $compile(template or defaultTemplate)($rootScope)
    $rootScope.$digest()

    elem

  beforeEach ->
    angular.mock.module('app')

    inject (_$rootScope_, _$compile_, _sentenceSplitter_) ->
      $rootScope = _$rootScope_.$new()
      $compile = _$compile_
      $sentenceSplitter = mockService

  it 'the directive should render three elements', ->
    $element = createDirective("")

    element = $element[0]

    expect(element.tagName).to.equal 'DIV'
    expect($element.children()).to.have.length 3

  it 'should produce an empty list if no data provided', ->
    $element = createDirective("").children()[2]

    element = $element

    expect(element.tagName).to.equal 'UL'
    expect(angular.element($element).children()).to.have.length 0

  it 'should produce list items from the data', ->
    $element = angular.element(createDirective(defaultData).children()[2])

    expect($element.children()).to.have.length 10

    _.each $element.children(), (child) ->
      expect(child.tagName).to.equal 'LI'
