window.Group =
  run: ->
    $(document).ready ->
      tickColor()

tickColor = ->
  $(".color").on "click", (e) ->
    $(".color-checked").removeClass("color-checked")
    $(this).find("i").addClass("color-checked")
    $("#group_them").val($(this).attr('id'))
