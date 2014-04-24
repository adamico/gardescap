$ = jQuery

$ ->
  $('.alert-message').alert()
  $('.equivalent-garde').calculateEqGarde()
  $('#modeEmploi').modal('show') if $('#modeEmploi').data('show') is 'true'

$.fn.calculateEqGarde = ->
  @each ->
    values =
      parseInt($(td).text()) / parseInt($(td).data('factor')) for td in $(@).parent().find('td')
    total = values.reduce (x, y) -> x + y
    $(@).text(total)
