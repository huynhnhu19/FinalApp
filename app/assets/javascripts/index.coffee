window.Index =
  run: ->
    $(document).ready ->
      boxClick()

boxClick = ->
  $("body").on 'click', '.box-click', (e) ->
    if $(e.target).parents(".post-content").attr("class") == "post-content"
      window.location = $(this).attr("id")