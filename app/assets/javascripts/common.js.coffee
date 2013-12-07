$ = jQuery

$ ->
  $(".editable").editable()
  $(".alert-message").alert()
  $("[rel=tooltip]").tooltip
    delay:
      hide: 100

  $.fn.select2.defaults.allowClear = true
  $.fn.select2.defaults.formatNoMatches = -> "Aucun résultat"
  $.fn.select2.defaults.formatInputTooShort = (input, min) -> "Saisir au moins #{min - input.length} caractères"
  $.fn.select2.defaults.formatSearching = -> "Recherche en cours..."
  $.fn.select2.defaults.width = "resolve"
