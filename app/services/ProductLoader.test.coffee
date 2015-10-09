angular.module('productApp', []).factory('productLoader', require './ProductLoader.coffee')

describe 'ProductLoader', ->

  $httpBackend = productLoader = null
  mockData = { "data" : [
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
    }
  ]}

  beforeEach ->
    angular.mock.module('productApp')

    inject (_$httpBackend_, _productLoader_) ->
      $httpBackend = _$httpBackend_
      productLoader = _productLoader_

  it 'fetching data through get returns the same amount of data as that which is loaded', ->

    $httpBackend.when('GET', 'data/data.json').respond(mockData)

    returnObject = productLoader.get().success( (result) ->
      expect(result.data.length).to.equal (mockData.data.length)
    )

    $httpBackend.flush()


