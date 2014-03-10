# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ = jQuery

$ ->
  $("[data-candidates]").getCellClass()

$.fn.getCellClass = ->
  @each ->
    candidates_number = new CandidateCount($(@).data("candidates"))
    css_class = candidates_number.get_css_class()
    $(@).attr("class", css_class)

class @CandidateCount
  constructor: (count) -> @count = parseInt(count, 10)
  get_css_class: ->
    return "success" if @count is 0
    return "warning" if @is_lower_than(5)
    "danger"

  is_lower_than: (number) -> @count > 0 and @count < number
