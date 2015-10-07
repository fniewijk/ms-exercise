module.exports = ($http) ->
  return {
    get: ->
      $http({
        method: 'GET',
        url: "data/data.json"
      })
  }

module.exports.$inject = ['$http']
