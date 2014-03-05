$ = jQuery

$ ->
  $(".equivalent-garde").calculateEqGarde()

$.fn.calculateEqGarde = ->
  @each ->
    values = 
      parseInt($(td).text()) / parseInt($(td).data("factor")) for td in $(@).parent().find("td")
    total = values.reduce (x, y) -> x + y
    $(@).text(total)
