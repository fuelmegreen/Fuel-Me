# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require jquery.libs
#= require twitter/bootstrap
#= require custom.select
#= require string
#= require_self

$ ->
  $('.dropdown-toggle').dropdown()
  $('a[rel=popover]').popover()
  $('a[rel=tooltip]').tooltip()
  $('.tooltip').tooltip()
  $('select').customize()
#  $('.tablesorter').tablesorter({widgets: ['zebra']})
#  $('a.help-link').pageslide({direction: 'left'})
