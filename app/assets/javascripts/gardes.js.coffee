# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ = jQuery

$ ->
  $("[data-candidates]").getCellClass()
  $(".tags").attachEditable()

$.fn.attachEditable = ->
  $(@)
    .editable
      params: (params) ->
        data = {garde: {}}
        data["garde"][params.name] = params.value
        return data
      select2:
        width: "300px"
        minimumInputLength: 3
        maximumSelectionSize: 5
        tags: true
        tokenSeparators: [","]
        createSearchChoice: (term, data) ->
          return { id: term, text: term } if $(data).filter(-> return this.text.localeCompare(term) is 0).length is 0
        multiple: true
        initSelection : (element, callback) ->
          data = []
          $(element.val().split(",")).each ->
            data.push({id: this, text: this})
          callback(data)
        ajax:
          url: "/tags"
          dataType: "json"
          data: (term, page) ->
            q: term
            page_limit: 10
          results: (data, page) ->
            return {results: data}
    .on "save", (e, params) ->
      candidates_number = new CandidateCount(params.newValue.length)
      $(@).parent().attr("class", candidates_number.get_css_class())

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
