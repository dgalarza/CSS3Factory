#= require vendor/jquery.uniform
#= require vendor/jquery.cookie
#= require vendor/colorpicker
#= require vendor/underscore
#= require vendor/jquery.zclip

#= require angularjs/angular
#= require react/react
#= require react/react-dom
#= require_self
#
#= require classes/GradientGenerator
#= require classes/Swatch
#= require_tree ./components
#= require_tree ./services
#= require_tree ./factories
#= require_tree ./directives
#= require controllers/GradientGeneratorCtrl

@css3factory = angular.module 'css3factory', []
