_ = require 'lodash'

describe 'ProductList', ->
  $rootScope = $compile = null
  defaultTemplate = '<product-list></product-list>'
  defaultData = {"data": [
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
  ]}

  createDirective = (data, template) ->
    $rootScope.data = data
    elem = $compile(template or defaultTemplate) $rootScope
    $rootScope.$digest()
    elem

  beforeEach ->

    inject (_$rootScope_, _$compile_) ->
      $rootScope = _$rootScope_.$new()
      $compile = _$compile_

  it 'should produce an empty list if no data provided', ->
    $element = createDirective()
    element = $element[0]

    expect(element.tagName).to.equal 'UL'
    expect($element.children()).to.have.length 0

  it 'should produce list items from the data', ->
    $element = createDirective(defaultData)

    expect($element.children()).to.have.length 3

    _.each $element.children(), (child) ->
      expect(child.tagName).to.equal 'LI'

  it 'should add a proper class to list items depending on the attachment type', ->
    $element = createDirective(defaultData)

    children = $element.children()

    expect(children[0].classList.contains 'file').to.be.true
    expect(children[0].classList.contains 'link').to.be.false
    expect(children[1].classList.contains 'file').to.be.true
    expect(children[1].classList.contains 'link').to.be.false
    expect(children[2].classList.contains 'file').to.be.false
    expect(children[2].classList.contains 'link').to.be.true
