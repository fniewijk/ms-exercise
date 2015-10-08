_ = require 'lodash'

require './SortDropdown.coffee'

describe 'SortDropdown', ->
  $rootScope = $compile = null
  defaultTemplate = '<sort-dropdown></sort-dropdown>'

  createDirective = (template) ->
    elem = $compile(defaultTemplate)($rootScope)
    $rootScope.$digest()
    elem

  beforeEach ->
    angular.mock.module('app')

    inject (_$rootScope_, _$compile_) ->
      $rootScope = _$rootScope_.$new()
      $compile = _$compile_

  it 'the directive should render one div containing one select', ->
    $element = createDirective()

    element = $element[0]

    expect(element.tagName).to.equal 'DIV'
    expect($element.children()[0].tagName).to.equal 'SELECT'

  it 'should have options in the select', ->
    $element = angular.element(createDirective().children()[0])

    _.each $element.children(), (child) ->
      expect(child.tagName).to.equal 'OPTION'
