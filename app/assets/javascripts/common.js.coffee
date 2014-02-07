$ = jQuery

$ ->
  $(".editable").editable()
  $(".alert-message").alert()

  $.fn.select2.defaults.allowClear = true
  $.fn.select2.defaults.formatNoMatches = -> "Aucun résultat"
  $.fn.select2.defaults.formatInputTooShort = (input, min) -> "Saisir au moins #{min - input.length} caractères"
  $.fn.select2.defaults.formatSelectionTooBig = (maxSize) -> "Pas plus de #{maxSize} personnes par plage"
  $.fn.select2.defaults.formatSearching = -> "Recherche en cours..."
  $.fn.select2.defaults.width = "resolve"
  $.fn.editable.defaults.emptytext = "Personne"
