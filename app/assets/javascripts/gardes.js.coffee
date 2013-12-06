# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ = jQuery

$ ->
  $("#garde_candidate_list").select2
    tags: true
    ajax:
      url: "/gardes/tags.json"
      dataType: "json"
      data: (term, page) ->
        q: term
        page_limit: 10
        results: (data, page) ->
          return {results: data}
    tokenSeparator: [","]
