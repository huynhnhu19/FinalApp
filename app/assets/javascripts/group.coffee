window.Group =
  run: ->
    $(document).ready ->
      tickColor()
      tickThem()
      joinGroup()
      leaveGroup()
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

joinGroup = ->
  $(".btn-join-small").on 'click', (e) ->
    $(this).removeClass("active").addClass("de-active")
    $(this).parent().find(".btn-leave-small").removeClass("de-active").addClass("active")

leaveGroup = ->
  $(".btn-leave-small").on 'click', (e) ->
    $(this).removeClass("active").addClass("de-active")
    $(this).parent().find(".btn-join-small").removeClass("de-active").addClass("active")