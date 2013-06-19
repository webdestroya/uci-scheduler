# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("a.search-details-toggle").click (event) ->
    event.preventDefault()
    $("tr.sched-details-row").toggle()
    return
  return