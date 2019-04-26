window.Group =
  run: ->
    $(document).ready ->
      tickColor()
      tickThem()

tickColor = ->
  $(".color").on "click", (e) ->
    $(".color-checked").removeClass("color-checked")
    $(this).find("i").addClass("color-checked")
    $("#group_text_color").val($(this).attr('id'))

tickThem = ->
  $(".them").on "click", (e) ->
    $(".color-checked").removeClass("them-checked")
    $(this).find("i").addClass("them-checked")
    $("#group_them").val($(this).attr('id'))
