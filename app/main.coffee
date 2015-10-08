$ = require 'jquery'
angular = require 'angular'
require './main.less'

mod = angular.module('app', [])
  .controller('AppController', require './controllers/AppController.coffee')

  .factory('sentenceSplitter', require './services/SentenceSplitter.coffee')
  .factory('productLoader', require './services/ProductLoader.coffee')

  .directive('sortDropdown', require './directives/sortdropdown/SortDropdown.coffee')
  .directive('productList', require './directives/productlist/ProductList.coffee')
  .directive('sentenceDetector', require './directives/sentencedetector/SentenceDetector.coffee')
