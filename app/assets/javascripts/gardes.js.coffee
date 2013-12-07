# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ = jQuery

$ ->
  $(".tags").each ->
    $(@).editable
      inputclass: "input-large"
      params: (params) ->
        data = {garde: {}}
        data["garde"][params.name] = params.value
        return data
      select2:
        tags: $(@).data("value")
        tokenSeparators: [","]
  $("#garde_candidate_list").select2
    minimumInputLength: 3
    tags: true
    tokenSeparators: [","]
    createSearchChoice: (term, data) ->
      return { id: term, text: term } if $(data).filter(-> return this.text.localeCompare(term) is 0).length is 0
    multiple: true
    initSelection : (element, callback) ->
      preload = element.data("load")
      callback(preload)
    ajax:
      url: "/tags.json"
      dataType: "json"
      data: (term, page) ->
        q: term
        page_limit: 10
      results: (data, page) ->
        return {results: data}
