_ = require 'lodash'

describe 'ProductList', ->
  $rootScope = $compile = null
  defaultTemplate = '<product-list data="data"></product-list>'
  defaultData = [
    {
      "name": "Pure Linen Easy to Iron Broderie Bodice Shift Dress",
      "price": 25
    },
    {
      "name": "Faux Snakeskin & Fire Print Maxi Dress",
      "price": 34,
      "promotion": "holiday promo"
    },
    {
      "name": "Mesh Lace Tunic Shift Dress",
      "price": 34
    },
    {
      "name": "Crinkle Effect Floral Shift Dress",
      "price": 24,
      "promotion": "promotion 1"
    }
  ]

  createDirective = (data, template) ->
    $rootScope.data = data
    elem = $compile(defaultTemplate)($rootScope)
    $rootScope.$digest()
    elem


  beforeEach ->
    angular.mock.module('app')

    inject (_$rootScope_, _$compile_) ->
      $rootScope = _$rootScope_.$new()
      $compile = _$compile_

  it 'the directive should render three elements', ->
    $element = createDirective(defaultData)

    element = $element[0]

    expect(element.tagName).to.equal 'DIV'
    expect($element.children()).to.have.length 3

  it 'should produce an empty list if no data provided', ->
    $element = createDirective([]).children()[2]

    element = $element

    expect(element.tagName).to.equal 'UL'
    expect(angular.element($element).children()).to.have.length 0

  it 'should produce list items from the data', ->
    $element = angular.element(createDirective(defaultData).children()[2])

    expect($element.children()).to.have.length 4

    _.each $element.children(), (child) ->
      expect(child.tagName).to.equal 'LI'
